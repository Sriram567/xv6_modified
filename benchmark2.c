#include "types.h"
#include "user.h"

int number_of_processes = 40;

void mixture()
{
  int j;
  for (j = 0; j < number_of_processes; j++)
  {
    int pid = fork();
    if (pid < 0)
    {
      printf(1, "Fork failed\n");
      continue;
    }
    if (pid == 0)
    {
      volatile int i;
      for (volatile int k = 0; k < number_of_processes; k++)
      {
        if (k <= j)
        {
          sleep(200); //io time
        }
        else
        {
          
            for (i = 0; i < 100000000; i++)
            {

                ; //cpu time
            }
          
        }
      }
//      printf(1, "Process: %d Finished %d pid\n", j,getpid());
      exit();
    }
    else{
        ;
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  {
    wait();
  }
  exit();
}

void cpubound()
{
  int j;
  for (j = 0; j < number_of_processes; j++)
  {
    int pid = fork();
    if (pid < 0)
    {
      printf(1, "Fork failed\n");
      continue;
    }
    if (pid == 0)
    {
      volatile int i;
      for (volatile int k = 0; k < number_of_processes; k++)
      {
        if (k <= j)
        {
          sleep(5); //io time
        }
        else
        {
    	    	      
            for (i = 0; i < 100000000; i++)
            {

                ; //cpu time
            }
	    
        }
      }
  //    printf(1, "Process: %d Finished %d pid\n", j,getpid());
      exit();
    }
    else{
        ;
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  {
    wait();
  }
  exit();
}

void iobound()
{
  int j;
  for (j = 0; j < number_of_processes; j++)
  {
    int pid = fork();
    if (pid < 0)
    {
      printf(1, "Fork failed\n");
      continue;
    }
    if (pid == 0)
    {
      volatile int i;
      for (volatile int k = 0; k < number_of_processes; k++)
      {
        if (k <= j)
        {
          sleep(200); //io time
        }
        else
        {
          
            for (i = 0; i < 1; i++)
            {

                ; //cpu time
            }
          
        }
      }
    //  printf(1, "Process: %d Finished %d pid\n", j,getpid());
      exit();
    }
    else{
        ;
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  {
    wait();
  }
  exit();
}


void mlfqprocess()
{
  int j;
  for (j = 0; j < number_of_processes; j++)
  {
    int pid = fork();
    if (pid < 0)
    {
      printf(1, "Fork failed\n");
      continue;
    }
    if (pid == 0)
    {
      volatile int i;
      for (volatile int k = 0; k < number_of_processes; k++)
      {
        if (k <= j)
        {
          if(j%4 == 0)
          {
           sleep(20);
          } //io time
          else
          {
            sleep(200);
          }
        }
        else
        {
            if(j%4 == 0)
            {
            for (i = 0; i < 100000000; i++)
            {

                ; //cpu time
            }}
            else{
            for (i = 0; i < 10000; i++)
            {

                ; //cpu time
            }}
          
        }
      }
    //  printf(1, "Process: %d Finished %d pid\n", j,getpid());
      exit();
    }
    else{
        ;
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  {
    wait();
  }
  exit();
}
int main(int argc, char *argv[])
{
    if(argc!=3)
    {
        printf(1,"Correct number of arguments has to be given\n");
    }
    number_of_processes= atoi(argv[2]);
    if(atoi(argv[1])==0)
    {
        mlfqprocess();
    }
    else if(atoi(argv[1]) == 1)
    {
        cpubound();
    }
    else if(atoi(argv[1]) == 2)
    {
        iobound();
    }
    else if(atoi(argv[1]) == 3)
    {
        mixture();
    }
}
