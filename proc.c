#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  p->ctime = ticks;
  p->lastentertime = ticks;
  p->rtime = 0;
  p->runtime = 0;
  p->wtime = 0;
  p->waittime = 0;
  p->iowaittime = 0;
  p->priority = 60;  // Default priority
  p->cur_q = -5;
  p->currentslice=0;
  if(p->pid < 3)
  {
	p->priority = 2;
  }
#ifdef YES
  cprintf("%d %d %d\n",ticks,p->pid,0);
#endif
#ifdef MLFQ
  p->cur_q = 0;
#endif
  
  for(int iii = 0;iii<6 ;iii++)
  {
    p->q[iii] = 0;
    p->qentertime[iii] = ticks;
  }
  p->n_run = 0;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.

  curproc->state = ZOMBIE;

#ifdef YES
  cprintf("%d %d %d\n",ticks , curproc->pid, curproc->cur_q);
#endif
 
//  cprintf("ENTERED exit\n");
  curproc->cur_q = -5;
  curproc->etime = ticks;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void aging()
{
  int agefactor[6];
  agefactor[0] = 25;
  agefactor[1] = 35;
  agefactor[2] = 40;
  agefactor[3] = 40;
  agefactor[4] = 50;
  struct proc * pp;
//  acquire(&ptable.lock);
  for(pp = ptable.proc; pp< &ptable.proc[NPROC]; pp++)
  {
    if(pp->state!= RUNNABLE || pp->cur_q < 0)
      continue;
    if(pp->waittime >= agefactor[pp->cur_q])
    {
      if(pp->cur_q >= 1)
      {
        pp->cur_q = pp->cur_q - 1;
	#ifdef YES
          cprintf("%d %d %d\n",ticks, pp->pid,pp->cur_q);
	#endif
        pp->currentslice = 0;
	pp->lastentertime = ticks;
	pp->wtime += pp->waittime;
        pp->waittime = 0;
        pp->iowaittime = 0;
        pp->qentertime[pp->cur_q] = ticks;
      }
    }
  }
 // release(&ptable.lock);
}


void updateruntime()
{
    struct proc *p;
    acquire (&ptable.lock);
    for (p=ptable.proc;p<&ptable.proc[NPROC];p++)
    {
        if (p->state == RUNNING)
        {
            p->runtime++;
	    p->q[p->cur_q]++;
            p->currentslice++;
        }
        if (p->state == RUNNABLE)
        {
            p->waittime++;
        }
	if(p->state == SLEEPING)
	{
	    p->iowaittime++;
	    p->waittime = 0;
	    p->lastentertime = ticks;
	}

    }
    release(&ptable.lock);

}
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
#ifdef MLFQ
  int maximumof[6] = {};
  maximumof[0] = 1;
  maximumof[1] = 2;
  maximumof[2] = 4;
  maximumof[3] = 8;
  maximumof[4] = 16;
#endif 
  for(;;)
  {
    // Enable interrupts on this processor.
    sti();
#ifdef MLFQ
  struct proc *bestprocess = 0;
  int minentertime = 100000000;
  int minqueue = 100000000;
  int find = 0;
  int lastexecutedpid = 0;
  acquire(&ptable.lock);
  aging();
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    //cprintf("YES\n");
    if(p->state != RUNNABLE)
    {
      continue;
    }
    else 
    {
      if(p->cur_q < minqueue)
      {
        find = 1;
        bestprocess = p;
        minqueue = p->cur_q;
        minentertime = p->qentertime[minqueue] + p->iowaittime;
      }
      else if(p->cur_q == minqueue)
      {
        if(p->qentertime[minqueue] + p->iowaittime < minentertime)
        {
          find = 1;
          bestprocess = p;
          minqueue = p->cur_q;
          minentertime = p->qentertime[minqueue];
        }
      }
    }
  }
 // cprintf(" find = %dYES YES \n",find);
 // bestprocess->currentslice = 1 - 1;
  for(;;)
  {
    if(find > 0)
    {
      if(minqueue == bestprocess->cur_q)
      {
//      bestprocess->q[minqueue]++;
        if(bestprocess->pid != lastexecutedpid)
        {
          bestprocess->n_run++;
          lastexecutedpid = bestprocess->pid;
        }
        c->proc = bestprocess;
        switchuvm(bestprocess);
	bestprocess->lastentertime = ticks;
        bestprocess->state = RUNNING;
	bestprocess->wtime += bestprocess->waittime;
        bestprocess->waittime = 0;
        bestprocess->iowaittime = 0;
        swtch(&(c->scheduler), bestprocess->context);
        switchkvm();
	c->proc = 0;
      }
      // CODE FOR DEMOTING A PROCESS
      minqueue= bestprocess->cur_q;
      if(bestprocess->currentslice >= maximumof[minqueue] && bestprocess->state != ZOMBIE && bestprocess->cur_q > -1 && bestprocess->pid >2 )
      {
        bestprocess->currentslice = 0;
        if(minqueue >= 4)
        {
          bestprocess->qentertime[minqueue] = ticks;
	  
          bestprocess->waittime = 0;
	  p->wtime += p->waittime;
        }
        else
        {
          bestprocess->cur_q = bestprocess->cur_q + 1;
	  #ifdef YES
	    cprintf("%d %d %d\n",ticks, bestprocess->pid,bestprocess->cur_q);
	  #endif
          bestprocess->qentertime[minqueue] = ticks;
	        bestprocess->lastentertime = ticks;
          bestprocess->waittime = 0;
	  p->wtime += p->waittime;
	}
        break;
      }
      if(bestprocess->state == SLEEPING)
      {
	      bestprocess->currentslice = 0;
        bestprocess->qentertime[minqueue] = ticks;
        bestprocess->waittime = 0;
	      p->wtime += p->waittime;
        break;
      }
      aging();
    }
    // bestprocess->lastentertime = ticks;
    break;
  }
  
  find = 0;
  release(&ptable.lock);
#endif


#ifdef RR
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
      p->n_run++;
      p->wtime +=  p->waittime;
      p->waittime = 0;
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
#endif

#ifdef FCFS
    struct proc * fcfsp =0 ;
    int minstarttime = 100000000;
    int find = 0;
    int minpid = 100000000;
    //int minpid = 10000000;
    
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
      else 
      {
         if(p->ctime < minstarttime)
         {
           find = 1;
           minstarttime = p->ctime;
           fcfsp = p;
	   minpid =  fcfsp->pid;
         }
         else if(p->ctime == minstarttime)
         {
           if(p->pid < minpid)
           {
	    find  =1;
            fcfsp = p;
	    minpid = fcfsp->pid;
           }
         }
      }

    }
    if(find)
    {
      c->proc = fcfsp;
    
      switchuvm(fcfsp);
      fcfsp->state = RUNNING;
      fcfsp->n_run++;
      fcfsp->wtime += fcfsp->waittime;
      fcfsp->waittime = 0;
      swtch(&(c->scheduler), fcfsp->context);
      switchkvm();
      p->lastentertime = ticks;
      
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
#endif

#ifdef PBS

  int find = 0;
  //struct proc *  pbsp =0;
  int minpriority = 1000;
  //int minnpid = 100000000;
  acquire(&ptable.lock);
  // Finding the process with minimum priority

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE) // The process has to be runnable to schedule
          continue;
        else 
        {
            if (p->priority < minpriority)
            {
		    find = 1;
    //              pbsp = p;
                minpriority=p->priority;
  //	      minnpid = p->pid;
            }
        }
  }
  if(find == 1) // If there is any process
  {
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->state !=RUNNABLE)
    {
	    continue;
    }
    // we schedule them only if they have minimum priority and they 
    // are in runnable state.
    if(minpriority == p->priority && p->state == RUNNABLE)
    {
        c->proc = p;
        switchuvm(p);
        p->state = RUNNING;
        p->n_run++;
        p->wtime += p->waittime;
        p->waittime = 0;
        swtch(&(c->scheduler), p->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
        struct proc * isitmin = 0;
        int ff = 0;
        // To include premption
        // We check if any higher priority process has entered
        for(isitmin = ptable.proc; isitmin < &ptable.proc[NPROC]; isitmin++)
	{
	 if(isitmin->state != RUNNABLE)
        	 continue;
          else
          {
            if (isitmin->priority < minpriority)
            {
    //      pbsp = p;
              ff =1;
              break;
    //      minnpid = p->pid;
            }
          }
      }
        if(ff == 1)
        {
          ff = 0;
          break;
        }
    }

  }
  }
  else
  {
	  release(&ptable.lock);
	  continue;
  }
  
  release(&ptable.lock);

#endif
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
int
waitx(int * waittime , int * runtime )
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        *waittime = (p->etime - p->ctime - p->runtime);
	      p->rtime =  p->runtime + p->waittime + p->iowaittime;
        *runtime = p->runtime;

       /* cprintf("etime =%d ctime=%d runtime=%d \n iowaittime = %d \n",
                p->etime,p->ctime,p->runtime,p->iowaittime );*/


        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

int set_priority(int new_priority, int pid)
{
 // cprintf("priority = %d , pid = %d \n",new_priority,pid);
  if(new_priority > 100 || new_priority < 0)
  {
    return -1;
  }
  int find = 0;
  int rt = -1;
  struct proc * p;
  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->pid!=0)
 //   cprintf("Pids present are %d\n",p->pid);
    if(pid == p->pid)
    {
      find = 1;
      rt = p->priority;
      p->priority = new_priority;
      break;
    }
  }
  release(&ptable.lock);
  if(rt > new_priority)
  {
  	yield();
  }
  if(find == 0)
  {
	  cprintf("The process with given pid = %d  is not yet created or exited earlier\n",pid,new_priority);
	  return -1;
  }
  if(find)
  {
    if(new_priority > 100 || new_priority < 0)
    {
      return -1;
    }
    return rt;
  }
  else
  {
    return -1;
  }
  
}

int ps(void)
{
  struct proc *p;
  acquire(&ptable.lock);
  cprintf("PID \t Priority \t State \t \t r_time \t w_time \t n_run \t cur_q \t q0 \t q1 \t q2 \t q3 \t q4 \n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == SLEEPING)
      cprintf("%d \t %d \t \t sleeping \t %d \t \t %d \t \t %d \t %d \t %d \t %d \t %d \t %d \t %d\n", p->pid, p->priority, p->runtime, p->waittime, p->n_run,p->cur_q,p->q[0],p->q[1],p->q[2],p->q[3],p->q[4]);
    else if (p->state == RUNNING)
      cprintf("%d \t %d \t \t running \t %d \t \t %d \t \t %d \t %d \t %d \t %d \t %d \t %d \t %d\n", p->pid, p->priority, p->runtime, p->waittime, p->n_run,p->cur_q,p->q[0],p->q[1],p->q[2],p->q[3],p->q[4]);
    else if (p->state == RUNNABLE)
      cprintf("%d \t %d \t \t runnable \t %d \t \t %d \t \t %d \t %d \t %d \t %d \t %d \t %d \t %d\n", p->pid, p->priority, p->runtime, p->waittime, p->n_run,p->cur_q,p->q[0],p->q[1],p->q[2],p->q[3],p->q[4]);
    else if(p->state == ZOMBIE)
      cprintf("%d \t %d \t \t zombie \t %d \t \t %d \t \t %d \t %d \t %d \t %d \t %d \t %d \t %d\n", p->pid, p->priority, p->runtime, p->waittime, p->n_run,p->cur_q,p->q[0],p->q[1],p->q[2],p->q[3],p->q[4]);

  }
  release(&ptable.lock);
  return 24;
}
