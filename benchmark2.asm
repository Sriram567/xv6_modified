
_benchmark2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    wait();
  }
  exit();
}
int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
    if(argc!=3)
   e:	83 39 03             	cmpl   $0x3,(%ecx)
{
  11:	55                   	push   %ebp
  12:	89 e5                	mov    %esp,%ebp
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
    if(argc!=3)
  19:	74 11                	je     2c <main+0x2c>
    {
        printf(1,"Correct number of arguments has to be given\n");
  1b:	52                   	push   %edx
  1c:	52                   	push   %edx
  1d:	68 38 0c 00 00       	push   $0xc38
  22:	6a 01                	push   $0x1
  24:	e8 97 08 00 00       	call   8c0 <printf>
  29:	83 c4 10             	add    $0x10,%esp
    }
    number_of_processes= atoi(argv[2]);
  2c:	83 ec 0c             	sub    $0xc,%esp
  2f:	ff 73 08             	pushl  0x8(%ebx)
  32:	e8 a9 06 00 00       	call   6e0 <atoi>
  37:	a3 a8 0f 00 00       	mov    %eax,0xfa8
    if(atoi(argv[1])==0)
  3c:	58                   	pop    %eax
  3d:	ff 73 04             	pushl  0x4(%ebx)
  40:	e8 9b 06 00 00       	call   6e0 <atoi>
  45:	83 c4 10             	add    $0x10,%esp
  48:	85 c0                	test   %eax,%eax
  4a:	74 45                	je     91 <main+0x91>
    {
        mlfqprocess();
    }
    else if(atoi(argv[1]) == 1)
  4c:	83 ec 0c             	sub    $0xc,%esp
  4f:	ff 73 04             	pushl  0x4(%ebx)
  52:	e8 89 06 00 00       	call   6e0 <atoi>
  57:	83 c4 10             	add    $0x10,%esp
  5a:	83 f8 01             	cmp    $0x1,%eax
  5d:	74 41                	je     a0 <main+0xa0>
    {
        cpubound();
    }
    else if(atoi(argv[1]) == 2)
  5f:	83 ec 0c             	sub    $0xc,%esp
  62:	ff 73 04             	pushl  0x4(%ebx)
  65:	e8 76 06 00 00       	call   6e0 <atoi>
  6a:	83 c4 10             	add    $0x10,%esp
  6d:	83 f8 02             	cmp    $0x2,%eax
  70:	74 29                	je     9b <main+0x9b>
    {
        iobound();
    }
    else if(atoi(argv[1]) == 3)
  72:	83 ec 0c             	sub    $0xc,%esp
  75:	ff 73 04             	pushl  0x4(%ebx)
  78:	e8 63 06 00 00       	call   6e0 <atoi>
  7d:	83 c4 10             	add    $0x10,%esp
  80:	83 f8 03             	cmp    $0x3,%eax
  83:	74 11                	je     96 <main+0x96>
    {
        mixture();
    }
}
  85:	8d 65 f8             	lea    -0x8(%ebp),%esp
  88:	31 c0                	xor    %eax,%eax
  8a:	59                   	pop    %ecx
  8b:	5b                   	pop    %ebx
  8c:	5d                   	pop    %ebp
  8d:	8d 61 fc             	lea    -0x4(%ecx),%esp
  90:	c3                   	ret    
        mlfqprocess();
  91:	e8 1a 03 00 00       	call   3b0 <mlfqprocess>
        mixture();
  96:	e8 15 00 00 00       	call   b0 <mixture>
        iobound();
  9b:	e8 10 02 00 00       	call   2b0 <iobound>
        cpubound();
  a0:	e8 0b 01 00 00       	call   1b0 <cpubound>
  a5:	66 90                	xchg   %ax,%ax
  a7:	66 90                	xchg   %ax,%ax
  a9:	66 90                	xchg   %ax,%ax
  ab:	66 90                	xchg   %ax,%ax
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <mixture>:
{
  b0:	f3 0f 1e fb          	endbr32 
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	56                   	push   %esi
  b8:	53                   	push   %ebx
  b9:	83 ec 10             	sub    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
  bc:	a1 a8 0f 00 00       	mov    0xfa8,%eax
  c1:	85 c0                	test   %eax,%eax
  c3:	7e 4f                	jle    114 <mixture+0x64>
  c5:	31 db                	xor    %ebx,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
  c7:	be 50 00 00 00       	mov    $0x50,%esi
  cc:	eb 20                	jmp    ee <mixture+0x3e>
  ce:	66 90                	xchg   %ax,%ax
    if (pid == 0)
  d0:	74 67                	je     139 <mixture+0x89>
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
  d2:	83 ec 08             	sub    $0x8,%esp
  d5:	50                   	push   %eax
  d6:	89 f0                	mov    %esi,%eax
  d8:	29 d8                	sub    %ebx,%eax
  for (j = 0; j < number_of_processes; j++)
  da:	83 c3 01             	add    $0x1,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
  dd:	50                   	push   %eax
  de:	e8 18 07 00 00       	call   7fb <set_priority>
  e3:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
  e6:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
  ec:	7e 26                	jle    114 <mixture+0x64>
    int pid = fork();
  ee:	e8 58 06 00 00       	call   74b <fork>
    if (pid < 0)
  f3:	85 c0                	test   %eax,%eax
  f5:	79 d9                	jns    d0 <mixture+0x20>
      printf(1, "Fork failed\n");
  f7:	83 ec 08             	sub    $0x8,%esp
  for (j = 0; j < number_of_processes; j++)
  fa:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Fork failed\n");
  fd:	68 28 0c 00 00       	push   $0xc28
 102:	6a 01                	push   $0x1
 104:	e8 b7 07 00 00       	call   8c0 <printf>
      continue;
 109:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 10c:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 112:	7f da                	jg     ee <mixture+0x3e>
  for (j = 0; j < number_of_processes+5; j++)
 114:	83 3d a8 0f 00 00 fc 	cmpl   $0xfffffffc,0xfa8
 11b:	7c 17                	jl     134 <mixture+0x84>
 11d:	31 db                	xor    %ebx,%ebx
 11f:	90                   	nop
    wait();
 120:	e8 36 06 00 00       	call   75b <wait>
  for (j = 0; j < number_of_processes+5; j++)
 125:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 12a:	83 c3 01             	add    $0x1,%ebx
 12d:	83 c0 04             	add    $0x4,%eax
 130:	39 d8                	cmp    %ebx,%eax
 132:	7d ec                	jge    120 <mixture+0x70>
      exit();
 134:	e8 1a 06 00 00       	call   753 <exit>
      for (volatile int k = 0; k < number_of_processes; k++)
 139:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 140:	8b 45 f4             	mov    -0xc(%ebp),%eax
 143:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 149:	7c 29                	jl     174 <mixture+0xc4>
 14b:	eb e7                	jmp    134 <mixture+0x84>
 14d:	8d 76 00             	lea    0x0(%esi),%esi
          sleep(200); //io time
 150:	83 ec 0c             	sub    $0xc,%esp
 153:	68 c8 00 00 00       	push   $0xc8
 158:	e8 86 06 00 00       	call   7e3 <sleep>
 15d:	83 c4 10             	add    $0x10,%esp
      for (volatile int k = 0; k < number_of_processes; k++)
 160:	8b 45 f4             	mov    -0xc(%ebp),%eax
 163:	83 c0 01             	add    $0x1,%eax
 166:	89 45 f4             	mov    %eax,-0xc(%ebp)
 169:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16c:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 172:	7d c0                	jge    134 <mixture+0x84>
        if (k <= j)
 174:	8b 45 f4             	mov    -0xc(%ebp),%eax
 177:	39 d8                	cmp    %ebx,%eax
 179:	7e d5                	jle    150 <mixture+0xa0>
            for (i = 0; i < 100000000; i++)
 17b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 182:	8b 45 f0             	mov    -0x10(%ebp),%eax
 185:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 18a:	7f d4                	jg     160 <mixture+0xb0>
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	8b 45 f0             	mov    -0x10(%ebp),%eax
 193:	83 c0 01             	add    $0x1,%eax
 196:	89 45 f0             	mov    %eax,-0x10(%ebp)
 199:	8b 45 f0             	mov    -0x10(%ebp),%eax
 19c:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 1a1:	7e ed                	jle    190 <mixture+0xe0>
 1a3:	eb bb                	jmp    160 <mixture+0xb0>
 1a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <cpubound>:
{
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	56                   	push   %esi
 1b8:	53                   	push   %ebx
 1b9:	83 ec 10             	sub    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 1bc:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 1c1:	85 c0                	test   %eax,%eax
 1c3:	7e 4f                	jle    214 <cpubound+0x64>
 1c5:	31 db                	xor    %ebx,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 1c7:	be 50 00 00 00       	mov    $0x50,%esi
 1cc:	eb 20                	jmp    1ee <cpubound+0x3e>
 1ce:	66 90                	xchg   %ax,%ax
    if (pid == 0)
 1d0:	74 67                	je     239 <cpubound+0x89>
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 1d2:	83 ec 08             	sub    $0x8,%esp
 1d5:	50                   	push   %eax
 1d6:	89 f0                	mov    %esi,%eax
 1d8:	29 d8                	sub    %ebx,%eax
  for (j = 0; j < number_of_processes; j++)
 1da:	83 c3 01             	add    $0x1,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 1dd:	50                   	push   %eax
 1de:	e8 18 06 00 00       	call   7fb <set_priority>
 1e3:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 1e6:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 1ec:	7e 26                	jle    214 <cpubound+0x64>
    int pid = fork();
 1ee:	e8 58 05 00 00       	call   74b <fork>
    if (pid < 0)
 1f3:	85 c0                	test   %eax,%eax
 1f5:	79 d9                	jns    1d0 <cpubound+0x20>
      printf(1, "Fork failed\n");
 1f7:	83 ec 08             	sub    $0x8,%esp
  for (j = 0; j < number_of_processes; j++)
 1fa:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Fork failed\n");
 1fd:	68 28 0c 00 00       	push   $0xc28
 202:	6a 01                	push   $0x1
 204:	e8 b7 06 00 00       	call   8c0 <printf>
      continue;
 209:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 20c:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 212:	7f da                	jg     1ee <cpubound+0x3e>
  for (j = 0; j < number_of_processes+5; j++)
 214:	83 3d a8 0f 00 00 fc 	cmpl   $0xfffffffc,0xfa8
 21b:	7c 17                	jl     234 <cpubound+0x84>
 21d:	31 db                	xor    %ebx,%ebx
 21f:	90                   	nop
    wait();
 220:	e8 36 05 00 00       	call   75b <wait>
  for (j = 0; j < number_of_processes+5; j++)
 225:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 22a:	83 c3 01             	add    $0x1,%ebx
 22d:	83 c0 04             	add    $0x4,%eax
 230:	39 d8                	cmp    %ebx,%eax
 232:	7d ec                	jge    220 <cpubound+0x70>
      exit();
 234:	e8 1a 05 00 00       	call   753 <exit>
      for (volatile int k = 0; k < number_of_processes; k++)
 239:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 240:	8b 45 f4             	mov    -0xc(%ebp),%eax
 243:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 249:	7c 26                	jl     271 <cpubound+0xc1>
 24b:	eb e7                	jmp    234 <cpubound+0x84>
 24d:	8d 76 00             	lea    0x0(%esi),%esi
          sleep(5); //io time
 250:	83 ec 0c             	sub    $0xc,%esp
 253:	6a 05                	push   $0x5
 255:	e8 89 05 00 00       	call   7e3 <sleep>
 25a:	83 c4 10             	add    $0x10,%esp
      for (volatile int k = 0; k < number_of_processes; k++)
 25d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 260:	83 c0 01             	add    $0x1,%eax
 263:	89 45 f4             	mov    %eax,-0xc(%ebp)
 266:	8b 45 f4             	mov    -0xc(%ebp),%eax
 269:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 26f:	7d c3                	jge    234 <cpubound+0x84>
        if (k <= j)
 271:	8b 45 f4             	mov    -0xc(%ebp),%eax
 274:	39 d8                	cmp    %ebx,%eax
 276:	7e d8                	jle    250 <cpubound+0xa0>
            for (i = 0; i < 100000000; i++)
 278:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 27f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 282:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 287:	7f d4                	jg     25d <cpubound+0xad>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 290:	8b 45 f0             	mov    -0x10(%ebp),%eax
 293:	83 c0 01             	add    $0x1,%eax
 296:	89 45 f0             	mov    %eax,-0x10(%ebp)
 299:	8b 45 f0             	mov    -0x10(%ebp),%eax
 29c:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 2a1:	7e ed                	jle    290 <cpubound+0xe0>
 2a3:	eb b8                	jmp    25d <cpubound+0xad>
 2a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <iobound>:
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	56                   	push   %esi
 2b8:	53                   	push   %ebx
 2b9:	83 ec 10             	sub    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 2bc:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 2c1:	85 c0                	test   %eax,%eax
 2c3:	7e 4f                	jle    314 <iobound+0x64>
 2c5:	31 db                	xor    %ebx,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 2c7:	be 50 00 00 00       	mov    $0x50,%esi
 2cc:	eb 20                	jmp    2ee <iobound+0x3e>
 2ce:	66 90                	xchg   %ax,%ax
    if (pid == 0)
 2d0:	74 67                	je     339 <iobound+0x89>
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 2d2:	83 ec 08             	sub    $0x8,%esp
 2d5:	50                   	push   %eax
 2d6:	89 f0                	mov    %esi,%eax
 2d8:	29 d8                	sub    %ebx,%eax
  for (j = 0; j < number_of_processes; j++)
 2da:	83 c3 01             	add    $0x1,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 2dd:	50                   	push   %eax
 2de:	e8 18 05 00 00       	call   7fb <set_priority>
 2e3:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 2e6:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 2ec:	7e 26                	jle    314 <iobound+0x64>
    int pid = fork();
 2ee:	e8 58 04 00 00       	call   74b <fork>
    if (pid < 0)
 2f3:	85 c0                	test   %eax,%eax
 2f5:	79 d9                	jns    2d0 <iobound+0x20>
      printf(1, "Fork failed\n");
 2f7:	83 ec 08             	sub    $0x8,%esp
  for (j = 0; j < number_of_processes; j++)
 2fa:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Fork failed\n");
 2fd:	68 28 0c 00 00       	push   $0xc28
 302:	6a 01                	push   $0x1
 304:	e8 b7 05 00 00       	call   8c0 <printf>
      continue;
 309:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 30c:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 312:	7f da                	jg     2ee <iobound+0x3e>
  for (j = 0; j < number_of_processes+5; j++)
 314:	83 3d a8 0f 00 00 fc 	cmpl   $0xfffffffc,0xfa8
 31b:	7c 17                	jl     334 <iobound+0x84>
 31d:	31 db                	xor    %ebx,%ebx
 31f:	90                   	nop
    wait();
 320:	e8 36 04 00 00       	call   75b <wait>
  for (j = 0; j < number_of_processes+5; j++)
 325:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 32a:	83 c3 01             	add    $0x1,%ebx
 32d:	83 c0 04             	add    $0x4,%eax
 330:	39 d8                	cmp    %ebx,%eax
 332:	7d ec                	jge    320 <iobound+0x70>
      exit();
 334:	e8 1a 04 00 00       	call   753 <exit>
      for (volatile int k = 0; k < number_of_processes; k++)
 339:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 340:	8b 45 f4             	mov    -0xc(%ebp),%eax
 343:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 349:	7c 29                	jl     374 <iobound+0xc4>
 34b:	eb e7                	jmp    334 <iobound+0x84>
 34d:	8d 76 00             	lea    0x0(%esi),%esi
          sleep(200); //io time
 350:	83 ec 0c             	sub    $0xc,%esp
 353:	68 c8 00 00 00       	push   $0xc8
 358:	e8 86 04 00 00       	call   7e3 <sleep>
 35d:	83 c4 10             	add    $0x10,%esp
      for (volatile int k = 0; k < number_of_processes; k++)
 360:	8b 45 f4             	mov    -0xc(%ebp),%eax
 363:	83 c0 01             	add    $0x1,%eax
 366:	89 45 f4             	mov    %eax,-0xc(%ebp)
 369:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36c:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 372:	7d c0                	jge    334 <iobound+0x84>
        if (k <= j)
 374:	8b 45 f4             	mov    -0xc(%ebp),%eax
 377:	39 d8                	cmp    %ebx,%eax
 379:	7e d5                	jle    350 <iobound+0xa0>
            for (i = 0; i < 1; i++)
 37b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 382:	8b 45 f0             	mov    -0x10(%ebp),%eax
 385:	85 c0                	test   %eax,%eax
 387:	7f d7                	jg     360 <iobound+0xb0>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 390:	8b 45 f0             	mov    -0x10(%ebp),%eax
 393:	83 c0 01             	add    $0x1,%eax
 396:	89 45 f0             	mov    %eax,-0x10(%ebp)
 399:	8b 45 f0             	mov    -0x10(%ebp),%eax
 39c:	85 c0                	test   %eax,%eax
 39e:	7e f0                	jle    390 <iobound+0xe0>
 3a0:	eb be                	jmp    360 <iobound+0xb0>
 3a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <mlfqprocess>:
{
 3b0:	f3 0f 1e fb          	endbr32 
 3b4:	55                   	push   %ebp
 3b5:	89 e5                	mov    %esp,%ebp
 3b7:	56                   	push   %esi
 3b8:	be 50 00 00 00       	mov    $0x50,%esi
 3bd:	53                   	push   %ebx
 3be:	31 db                	xor    %ebx,%ebx
 3c0:	83 ec 10             	sub    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 3c3:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 3c8:	85 c0                	test   %eax,%eax
 3ca:	7f 22                	jg     3ee <mlfqprocess+0x3e>
 3cc:	eb 46                	jmp    414 <mlfqprocess+0x64>
 3ce:	66 90                	xchg   %ax,%ax
    if (pid == 0)
 3d0:	74 67                	je     439 <mlfqprocess+0x89>
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 3d2:	83 ec 08             	sub    $0x8,%esp
 3d5:	50                   	push   %eax
 3d6:	89 f0                	mov    %esi,%eax
 3d8:	29 d8                	sub    %ebx,%eax
  for (j = 0; j < number_of_processes; j++)
 3da:	83 c3 01             	add    $0x1,%ebx
      set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
 3dd:	50                   	push   %eax
 3de:	e8 18 04 00 00       	call   7fb <set_priority>
 3e3:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 3e6:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 3ec:	7e 26                	jle    414 <mlfqprocess+0x64>
    int pid = fork();
 3ee:	e8 58 03 00 00       	call   74b <fork>
    if (pid < 0)
 3f3:	85 c0                	test   %eax,%eax
 3f5:	79 d9                	jns    3d0 <mlfqprocess+0x20>
      printf(1, "Fork failed\n");
 3f7:	83 ec 08             	sub    $0x8,%esp
  for (j = 0; j < number_of_processes; j++)
 3fa:	83 c3 01             	add    $0x1,%ebx
      printf(1, "Fork failed\n");
 3fd:	68 28 0c 00 00       	push   $0xc28
 402:	6a 01                	push   $0x1
 404:	e8 b7 04 00 00       	call   8c0 <printf>
      continue;
 409:	83 c4 10             	add    $0x10,%esp
  for (j = 0; j < number_of_processes; j++)
 40c:	39 1d a8 0f 00 00    	cmp    %ebx,0xfa8
 412:	7f da                	jg     3ee <mlfqprocess+0x3e>
  for (j = 0; j < number_of_processes+5; j++)
 414:	31 db                	xor    %ebx,%ebx
 416:	83 3d a8 0f 00 00 fc 	cmpl   $0xfffffffc,0xfa8
 41d:	7c 15                	jl     434 <mlfqprocess+0x84>
 41f:	90                   	nop
    wait();
 420:	e8 36 03 00 00       	call   75b <wait>
  for (j = 0; j < number_of_processes+5; j++)
 425:	a1 a8 0f 00 00       	mov    0xfa8,%eax
 42a:	83 c3 01             	add    $0x1,%ebx
 42d:	83 c0 04             	add    $0x4,%eax
 430:	39 d8                	cmp    %ebx,%eax
 432:	7d ec                	jge    420 <mlfqprocess+0x70>
      exit();
 434:	e8 1a 03 00 00       	call   753 <exit>
      for (volatile int k = 0; k < number_of_processes; k++)
 439:	89 de                	mov    %ebx,%esi
 43b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 442:	8b 45 f4             	mov    -0xc(%ebp),%eax
 445:	83 e6 03             	and    $0x3,%esi
 448:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 44e:	7c 2d                	jl     47d <mlfqprocess+0xcd>
 450:	eb e2                	jmp    434 <mlfqprocess+0x84>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          if(j%4 == 0)
 458:	85 f6                	test   %esi,%esi
 45a:	75 74                	jne    4d0 <mlfqprocess+0x120>
           sleep(20);
 45c:	83 ec 0c             	sub    $0xc,%esp
 45f:	6a 14                	push   $0x14
 461:	e8 7d 03 00 00       	call   7e3 <sleep>
 466:	83 c4 10             	add    $0x10,%esp
      for (volatile int k = 0; k < number_of_processes; k++)
 469:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46c:	83 c0 01             	add    $0x1,%eax
 46f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 472:	8b 45 f4             	mov    -0xc(%ebp),%eax
 475:	3b 05 a8 0f 00 00    	cmp    0xfa8,%eax
 47b:	7d b7                	jge    434 <mlfqprocess+0x84>
        if (k <= j)
 47d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 480:	39 d8                	cmp    %ebx,%eax
 482:	7e d4                	jle    458 <mlfqprocess+0xa8>
            for (i = 0; i < 100000000; i++)
 484:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 48b:	8b 45 f0             	mov    -0x10(%ebp),%eax
            if(j%4 == 0)
 48e:	85 f6                	test   %esi,%esi
 490:	75 32                	jne    4c4 <mlfqprocess+0x114>
            for (i = 0; i < 100000000; i++)
 492:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 497:	7f d0                	jg     469 <mlfqprocess+0xb9>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4a3:	83 c0 01             	add    $0x1,%eax
 4a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ac:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 4b1:	7e ed                	jle    4a0 <mlfqprocess+0xf0>
 4b3:	eb b4                	jmp    469 <mlfqprocess+0xb9>
 4b5:	8d 76 00             	lea    0x0(%esi),%esi
            for (i = 0; i < 10000; i++)
 4b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4bb:	83 c0 01             	add    $0x1,%eax
 4be:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c4:	3d 0f 27 00 00       	cmp    $0x270f,%eax
 4c9:	7e ed                	jle    4b8 <mlfqprocess+0x108>
 4cb:	eb 9c                	jmp    469 <mlfqprocess+0xb9>
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
            sleep(200);
 4d0:	83 ec 0c             	sub    $0xc,%esp
 4d3:	68 c8 00 00 00       	push   $0xc8
 4d8:	e8 06 03 00 00       	call   7e3 <sleep>
 4dd:	83 c4 10             	add    $0x10,%esp
 4e0:	eb 87                	jmp    469 <mlfqprocess+0xb9>
 4e2:	66 90                	xchg   %ax,%ax
 4e4:	66 90                	xchg   %ax,%ax
 4e6:	66 90                	xchg   %ax,%ax
 4e8:	66 90                	xchg   %ax,%ax
 4ea:	66 90                	xchg   %ax,%ax
 4ec:	66 90                	xchg   %ax,%ax
 4ee:	66 90                	xchg   %ax,%ax

000004f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4f0:	f3 0f 1e fb          	endbr32 
 4f4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4f5:	31 c0                	xor    %eax,%eax
{
 4f7:	89 e5                	mov    %esp,%ebp
 4f9:	53                   	push   %ebx
 4fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4fd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 500:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 504:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 507:	83 c0 01             	add    $0x1,%eax
 50a:	84 d2                	test   %dl,%dl
 50c:	75 f2                	jne    500 <strcpy+0x10>
    ;
  return os;
}
 50e:	89 c8                	mov    %ecx,%eax
 510:	5b                   	pop    %ebx
 511:	5d                   	pop    %ebp
 512:	c3                   	ret    
 513:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000520 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 520:	f3 0f 1e fb          	endbr32 
 524:	55                   	push   %ebp
 525:	89 e5                	mov    %esp,%ebp
 527:	53                   	push   %ebx
 528:	8b 4d 08             	mov    0x8(%ebp),%ecx
 52b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 52e:	0f b6 01             	movzbl (%ecx),%eax
 531:	0f b6 1a             	movzbl (%edx),%ebx
 534:	84 c0                	test   %al,%al
 536:	75 19                	jne    551 <strcmp+0x31>
 538:	eb 26                	jmp    560 <strcmp+0x40>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 540:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 544:	83 c1 01             	add    $0x1,%ecx
 547:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 54a:	0f b6 1a             	movzbl (%edx),%ebx
 54d:	84 c0                	test   %al,%al
 54f:	74 0f                	je     560 <strcmp+0x40>
 551:	38 d8                	cmp    %bl,%al
 553:	74 eb                	je     540 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 555:	29 d8                	sub    %ebx,%eax
}
 557:	5b                   	pop    %ebx
 558:	5d                   	pop    %ebp
 559:	c3                   	ret    
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 560:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 562:	29 d8                	sub    %ebx,%eax
}
 564:	5b                   	pop    %ebx
 565:	5d                   	pop    %ebp
 566:	c3                   	ret    
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax

00000570 <strlen>:

uint
strlen(const char *s)
{
 570:	f3 0f 1e fb          	endbr32 
 574:	55                   	push   %ebp
 575:	89 e5                	mov    %esp,%ebp
 577:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 57a:	80 3a 00             	cmpb   $0x0,(%edx)
 57d:	74 21                	je     5a0 <strlen+0x30>
 57f:	31 c0                	xor    %eax,%eax
 581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 588:	83 c0 01             	add    $0x1,%eax
 58b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 58f:	89 c1                	mov    %eax,%ecx
 591:	75 f5                	jne    588 <strlen+0x18>
    ;
  return n;
}
 593:	89 c8                	mov    %ecx,%eax
 595:	5d                   	pop    %ebp
 596:	c3                   	ret    
 597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 5a0:	31 c9                	xor    %ecx,%ecx
}
 5a2:	5d                   	pop    %ebp
 5a3:	89 c8                	mov    %ecx,%eax
 5a5:	c3                   	ret    
 5a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ad:	8d 76 00             	lea    0x0(%esi),%esi

000005b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5b0:	f3 0f 1e fb          	endbr32 
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	57                   	push   %edi
 5b8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5be:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c1:	89 d7                	mov    %edx,%edi
 5c3:	fc                   	cld    
 5c4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5c6:	89 d0                	mov    %edx,%eax
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
 5cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop

000005d0 <strchr>:

char*
strchr(const char *s, char c)
{
 5d0:	f3 0f 1e fb          	endbr32 
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	8b 45 08             	mov    0x8(%ebp),%eax
 5da:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 5de:	0f b6 10             	movzbl (%eax),%edx
 5e1:	84 d2                	test   %dl,%dl
 5e3:	75 16                	jne    5fb <strchr+0x2b>
 5e5:	eb 21                	jmp    608 <strchr+0x38>
 5e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ee:	66 90                	xchg   %ax,%ax
 5f0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 5f4:	83 c0 01             	add    $0x1,%eax
 5f7:	84 d2                	test   %dl,%dl
 5f9:	74 0d                	je     608 <strchr+0x38>
    if(*s == c)
 5fb:	38 d1                	cmp    %dl,%cl
 5fd:	75 f1                	jne    5f0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 5ff:	5d                   	pop    %ebp
 600:	c3                   	ret    
 601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 608:	31 c0                	xor    %eax,%eax
}
 60a:	5d                   	pop    %ebp
 60b:	c3                   	ret    
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000610 <gets>:

char*
gets(char *buf, int max)
{
 610:	f3 0f 1e fb          	endbr32 
 614:	55                   	push   %ebp
 615:	89 e5                	mov    %esp,%ebp
 617:	57                   	push   %edi
 618:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 619:	31 f6                	xor    %esi,%esi
{
 61b:	53                   	push   %ebx
 61c:	89 f3                	mov    %esi,%ebx
 61e:	83 ec 1c             	sub    $0x1c,%esp
 621:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 624:	eb 33                	jmp    659 <gets+0x49>
 626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	8d 45 e7             	lea    -0x19(%ebp),%eax
 636:	6a 01                	push   $0x1
 638:	50                   	push   %eax
 639:	6a 00                	push   $0x0
 63b:	e8 2b 01 00 00       	call   76b <read>
    if(cc < 1)
 640:	83 c4 10             	add    $0x10,%esp
 643:	85 c0                	test   %eax,%eax
 645:	7e 1c                	jle    663 <gets+0x53>
      break;
    buf[i++] = c;
 647:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 64b:	83 c7 01             	add    $0x1,%edi
 64e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 651:	3c 0a                	cmp    $0xa,%al
 653:	74 23                	je     678 <gets+0x68>
 655:	3c 0d                	cmp    $0xd,%al
 657:	74 1f                	je     678 <gets+0x68>
  for(i=0; i+1 < max; ){
 659:	83 c3 01             	add    $0x1,%ebx
 65c:	89 fe                	mov    %edi,%esi
 65e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 661:	7c cd                	jl     630 <gets+0x20>
 663:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 665:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 668:	c6 03 00             	movb   $0x0,(%ebx)
}
 66b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66e:	5b                   	pop    %ebx
 66f:	5e                   	pop    %esi
 670:	5f                   	pop    %edi
 671:	5d                   	pop    %ebp
 672:	c3                   	ret    
 673:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 677:	90                   	nop
 678:	8b 75 08             	mov    0x8(%ebp),%esi
 67b:	8b 45 08             	mov    0x8(%ebp),%eax
 67e:	01 de                	add    %ebx,%esi
 680:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 682:	c6 03 00             	movb   $0x0,(%ebx)
}
 685:	8d 65 f4             	lea    -0xc(%ebp),%esp
 688:	5b                   	pop    %ebx
 689:	5e                   	pop    %esi
 68a:	5f                   	pop    %edi
 68b:	5d                   	pop    %ebp
 68c:	c3                   	ret    
 68d:	8d 76 00             	lea    0x0(%esi),%esi

00000690 <stat>:

int
stat(const char *n, struct stat *st)
{
 690:	f3 0f 1e fb          	endbr32 
 694:	55                   	push   %ebp
 695:	89 e5                	mov    %esp,%ebp
 697:	56                   	push   %esi
 698:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 699:	83 ec 08             	sub    $0x8,%esp
 69c:	6a 00                	push   $0x0
 69e:	ff 75 08             	pushl  0x8(%ebp)
 6a1:	e8 ed 00 00 00       	call   793 <open>
  if(fd < 0)
 6a6:	83 c4 10             	add    $0x10,%esp
 6a9:	85 c0                	test   %eax,%eax
 6ab:	78 2b                	js     6d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 6ad:	83 ec 08             	sub    $0x8,%esp
 6b0:	ff 75 0c             	pushl  0xc(%ebp)
 6b3:	89 c3                	mov    %eax,%ebx
 6b5:	50                   	push   %eax
 6b6:	e8 f0 00 00 00       	call   7ab <fstat>
  close(fd);
 6bb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6be:	89 c6                	mov    %eax,%esi
  close(fd);
 6c0:	e8 b6 00 00 00       	call   77b <close>
  return r;
 6c5:	83 c4 10             	add    $0x10,%esp
}
 6c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6cb:	89 f0                	mov    %esi,%eax
 6cd:	5b                   	pop    %ebx
 6ce:	5e                   	pop    %esi
 6cf:	5d                   	pop    %ebp
 6d0:	c3                   	ret    
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 6d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6dd:	eb e9                	jmp    6c8 <stat+0x38>
 6df:	90                   	nop

000006e0 <atoi>:

int
atoi(const char *s)
{
 6e0:	f3 0f 1e fb          	endbr32 
 6e4:	55                   	push   %ebp
 6e5:	89 e5                	mov    %esp,%ebp
 6e7:	53                   	push   %ebx
 6e8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6eb:	0f be 02             	movsbl (%edx),%eax
 6ee:	8d 48 d0             	lea    -0x30(%eax),%ecx
 6f1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 6f4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 6f9:	77 1a                	ja     715 <atoi+0x35>
 6fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
    n = n*10 + *s++ - '0';
 700:	83 c2 01             	add    $0x1,%edx
 703:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 706:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 70a:	0f be 02             	movsbl (%edx),%eax
 70d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 710:	80 fb 09             	cmp    $0x9,%bl
 713:	76 eb                	jbe    700 <atoi+0x20>
  return n;
}
 715:	89 c8                	mov    %ecx,%eax
 717:	5b                   	pop    %ebx
 718:	5d                   	pop    %ebp
 719:	c3                   	ret    
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000720 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 720:	f3 0f 1e fb          	endbr32 
 724:	55                   	push   %ebp
 725:	89 e5                	mov    %esp,%ebp
 727:	57                   	push   %edi
 728:	8b 45 10             	mov    0x10(%ebp),%eax
 72b:	8b 55 08             	mov    0x8(%ebp),%edx
 72e:	56                   	push   %esi
 72f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 732:	85 c0                	test   %eax,%eax
 734:	7e 0f                	jle    745 <memmove+0x25>
 736:	01 d0                	add    %edx,%eax
  dst = vdst;
 738:	89 d7                	mov    %edx,%edi
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 740:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 741:	39 f8                	cmp    %edi,%eax
 743:	75 fb                	jne    740 <memmove+0x20>
  return vdst;
}
 745:	5e                   	pop    %esi
 746:	89 d0                	mov    %edx,%eax
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    

0000074b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 74b:	b8 01 00 00 00       	mov    $0x1,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <exit>:
SYSCALL(exit)
 753:	b8 02 00 00 00       	mov    $0x2,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <wait>:
SYSCALL(wait)
 75b:	b8 03 00 00 00       	mov    $0x3,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <pipe>:
SYSCALL(pipe)
 763:	b8 04 00 00 00       	mov    $0x4,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <read>:
SYSCALL(read)
 76b:	b8 05 00 00 00       	mov    $0x5,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <write>:
SYSCALL(write)
 773:	b8 10 00 00 00       	mov    $0x10,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <close>:
SYSCALL(close)
 77b:	b8 15 00 00 00       	mov    $0x15,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <kill>:
SYSCALL(kill)
 783:	b8 06 00 00 00       	mov    $0x6,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <exec>:
SYSCALL(exec)
 78b:	b8 07 00 00 00       	mov    $0x7,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <open>:
SYSCALL(open)
 793:	b8 0f 00 00 00       	mov    $0xf,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <mknod>:
SYSCALL(mknod)
 79b:	b8 11 00 00 00       	mov    $0x11,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <unlink>:
SYSCALL(unlink)
 7a3:	b8 12 00 00 00       	mov    $0x12,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <fstat>:
SYSCALL(fstat)
 7ab:	b8 08 00 00 00       	mov    $0x8,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <link>:
SYSCALL(link)
 7b3:	b8 13 00 00 00       	mov    $0x13,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <mkdir>:
SYSCALL(mkdir)
 7bb:	b8 14 00 00 00       	mov    $0x14,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <chdir>:
SYSCALL(chdir)
 7c3:	b8 09 00 00 00       	mov    $0x9,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <dup>:
SYSCALL(dup)
 7cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <getpid>:
SYSCALL(getpid)
 7d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <sbrk>:
SYSCALL(sbrk)
 7db:	b8 0c 00 00 00       	mov    $0xc,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <sleep>:
SYSCALL(sleep)
 7e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <uptime>:
SYSCALL(uptime)
 7eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <waitx>:
SYSCALL(waitx)
 7f3:	b8 16 00 00 00       	mov    $0x16,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <set_priority>:
SYSCALL(set_priority)
 7fb:	b8 17 00 00 00       	mov    $0x17,%eax
 800:	cd 40                	int    $0x40
 802:	c3                   	ret    

00000803 <ps>:
SYSCALL(ps)
 803:	b8 18 00 00 00       	mov    $0x18,%eax
 808:	cd 40                	int    $0x40
 80a:	c3                   	ret    
 80b:	66 90                	xchg   %ax,%ax
 80d:	66 90                	xchg   %ax,%ax
 80f:	90                   	nop

00000810 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 3c             	sub    $0x3c,%esp
 819:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 81c:	89 d1                	mov    %edx,%ecx
{
 81e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 821:	85 d2                	test   %edx,%edx
 823:	0f 89 7f 00 00 00    	jns    8a8 <printint+0x98>
 829:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 82d:	74 79                	je     8a8 <printint+0x98>
    neg = 1;
 82f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 836:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 838:	31 db                	xor    %ebx,%ebx
 83a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 83d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 840:	89 c8                	mov    %ecx,%eax
 842:	31 d2                	xor    %edx,%edx
 844:	89 cf                	mov    %ecx,%edi
 846:	f7 75 c4             	divl   -0x3c(%ebp)
 849:	0f b6 92 6c 0c 00 00 	movzbl 0xc6c(%edx),%edx
 850:	89 45 c0             	mov    %eax,-0x40(%ebp)
 853:	89 d8                	mov    %ebx,%eax
 855:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 858:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 85b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 85e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 861:	76 dd                	jbe    840 <printint+0x30>
  if(neg)
 863:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 866:	85 c9                	test   %ecx,%ecx
 868:	74 0c                	je     876 <printint+0x66>
    buf[i++] = '-';
 86a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 86f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 871:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 876:	8b 7d b8             	mov    -0x48(%ebp),%edi
 879:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 87d:	eb 07                	jmp    886 <printint+0x76>
 87f:	90                   	nop
 880:	0f b6 13             	movzbl (%ebx),%edx
 883:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 886:	83 ec 04             	sub    $0x4,%esp
 889:	88 55 d7             	mov    %dl,-0x29(%ebp)
 88c:	6a 01                	push   $0x1
 88e:	56                   	push   %esi
 88f:	57                   	push   %edi
 890:	e8 de fe ff ff       	call   773 <write>
  while(--i >= 0)
 895:	83 c4 10             	add    $0x10,%esp
 898:	39 de                	cmp    %ebx,%esi
 89a:	75 e4                	jne    880 <printint+0x70>
    putc(fd, buf[i]);
}
 89c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89f:	5b                   	pop    %ebx
 8a0:	5e                   	pop    %esi
 8a1:	5f                   	pop    %edi
 8a2:	5d                   	pop    %ebp
 8a3:	c3                   	ret    
 8a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8af:	eb 87                	jmp    838 <printint+0x28>
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop

000008c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8c0:	f3 0f 1e fb          	endbr32 
 8c4:	55                   	push   %ebp
 8c5:	89 e5                	mov    %esp,%ebp
 8c7:	57                   	push   %edi
 8c8:	56                   	push   %esi
 8c9:	53                   	push   %ebx
 8ca:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8cd:	8b 75 0c             	mov    0xc(%ebp),%esi
 8d0:	0f b6 1e             	movzbl (%esi),%ebx
 8d3:	84 db                	test   %bl,%bl
 8d5:	0f 84 b4 00 00 00    	je     98f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 8db:	8d 45 10             	lea    0x10(%ebp),%eax
 8de:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 8e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8e4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 8e6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8e9:	eb 33                	jmp    91e <printf+0x5e>
 8eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop
 8f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 8f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 8f8:	83 f8 25             	cmp    $0x25,%eax
 8fb:	74 17                	je     914 <printf+0x54>
  write(fd, &c, 1);
 8fd:	83 ec 04             	sub    $0x4,%esp
 900:	88 5d e7             	mov    %bl,-0x19(%ebp)
 903:	6a 01                	push   $0x1
 905:	57                   	push   %edi
 906:	ff 75 08             	pushl  0x8(%ebp)
 909:	e8 65 fe ff ff       	call   773 <write>
 90e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 911:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 914:	0f b6 1e             	movzbl (%esi),%ebx
 917:	83 c6 01             	add    $0x1,%esi
 91a:	84 db                	test   %bl,%bl
 91c:	74 71                	je     98f <printf+0xcf>
    c = fmt[i] & 0xff;
 91e:	0f be cb             	movsbl %bl,%ecx
 921:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 924:	85 d2                	test   %edx,%edx
 926:	74 c8                	je     8f0 <printf+0x30>
      }
    } else if(state == '%'){
 928:	83 fa 25             	cmp    $0x25,%edx
 92b:	75 e7                	jne    914 <printf+0x54>
      if(c == 'd'){
 92d:	83 f8 64             	cmp    $0x64,%eax
 930:	0f 84 9a 00 00 00    	je     9d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 936:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 93c:	83 f9 70             	cmp    $0x70,%ecx
 93f:	74 5f                	je     9a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 941:	83 f8 73             	cmp    $0x73,%eax
 944:	0f 84 d6 00 00 00    	je     a20 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 94a:	83 f8 63             	cmp    $0x63,%eax
 94d:	0f 84 8d 00 00 00    	je     9e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 953:	83 f8 25             	cmp    $0x25,%eax
 956:	0f 84 b4 00 00 00    	je     a10 <printf+0x150>
  write(fd, &c, 1);
 95c:	83 ec 04             	sub    $0x4,%esp
 95f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 963:	6a 01                	push   $0x1
 965:	57                   	push   %edi
 966:	ff 75 08             	pushl  0x8(%ebp)
 969:	e8 05 fe ff ff       	call   773 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 96e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 971:	83 c4 0c             	add    $0xc,%esp
 974:	6a 01                	push   $0x1
 976:	83 c6 01             	add    $0x1,%esi
 979:	57                   	push   %edi
 97a:	ff 75 08             	pushl  0x8(%ebp)
 97d:	e8 f1 fd ff ff       	call   773 <write>
  for(i = 0; fmt[i]; i++){
 982:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 986:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 989:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 98b:	84 db                	test   %bl,%bl
 98d:	75 8f                	jne    91e <printf+0x5e>
    }
  }
}
 98f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 992:	5b                   	pop    %ebx
 993:	5e                   	pop    %esi
 994:	5f                   	pop    %edi
 995:	5d                   	pop    %ebp
 996:	c3                   	ret    
 997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 9a8:	6a 00                	push   $0x0
 9aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 9ad:	8b 45 08             	mov    0x8(%ebp),%eax
 9b0:	8b 13                	mov    (%ebx),%edx
 9b2:	e8 59 fe ff ff       	call   810 <printint>
        ap++;
 9b7:	89 d8                	mov    %ebx,%eax
 9b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9bc:	31 d2                	xor    %edx,%edx
        ap++;
 9be:	83 c0 04             	add    $0x4,%eax
 9c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 9c4:	e9 4b ff ff ff       	jmp    914 <printf+0x54>
 9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 9d0:	83 ec 0c             	sub    $0xc,%esp
 9d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9d8:	6a 01                	push   $0x1
 9da:	eb ce                	jmp    9aa <printf+0xea>
 9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 9e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 9e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 9e8:	6a 01                	push   $0x1
        ap++;
 9ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 9ed:	57                   	push   %edi
 9ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 9f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9f4:	e8 7a fd ff ff       	call   773 <write>
        ap++;
 9f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 9fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9ff:	31 d2                	xor    %edx,%edx
 a01:	e9 0e ff ff ff       	jmp    914 <printf+0x54>
 a06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 a10:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 a13:	83 ec 04             	sub    $0x4,%esp
 a16:	e9 59 ff ff ff       	jmp    974 <printf+0xb4>
 a1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a1f:	90                   	nop
        s = (char*)*ap;
 a20:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a23:	8b 18                	mov    (%eax),%ebx
        ap++;
 a25:	83 c0 04             	add    $0x4,%eax
 a28:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 a2b:	85 db                	test   %ebx,%ebx
 a2d:	74 17                	je     a46 <printf+0x186>
        while(*s != 0){
 a2f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 a32:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 a34:	84 c0                	test   %al,%al
 a36:	0f 84 d8 fe ff ff    	je     914 <printf+0x54>
 a3c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a3f:	89 de                	mov    %ebx,%esi
 a41:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a44:	eb 1a                	jmp    a60 <printf+0x1a0>
          s = "(null)";
 a46:	bb 65 0c 00 00       	mov    $0xc65,%ebx
        while(*s != 0){
 a4b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a4e:	b8 28 00 00 00       	mov    $0x28,%eax
 a53:	89 de                	mov    %ebx,%esi
 a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a5f:	90                   	nop
  write(fd, &c, 1);
 a60:	83 ec 04             	sub    $0x4,%esp
          s++;
 a63:	83 c6 01             	add    $0x1,%esi
 a66:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a69:	6a 01                	push   $0x1
 a6b:	57                   	push   %edi
 a6c:	53                   	push   %ebx
 a6d:	e8 01 fd ff ff       	call   773 <write>
        while(*s != 0){
 a72:	0f b6 06             	movzbl (%esi),%eax
 a75:	83 c4 10             	add    $0x10,%esp
 a78:	84 c0                	test   %al,%al
 a7a:	75 e4                	jne    a60 <printf+0x1a0>
 a7c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 a7f:	31 d2                	xor    %edx,%edx
 a81:	e9 8e fe ff ff       	jmp    914 <printf+0x54>
 a86:	66 90                	xchg   %ax,%ax
 a88:	66 90                	xchg   %ax,%ax
 a8a:	66 90                	xchg   %ax,%ax
 a8c:	66 90                	xchg   %ax,%ax
 a8e:	66 90                	xchg   %ax,%ax

00000a90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a90:	f3 0f 1e fb          	endbr32 
 a94:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a95:	a1 ac 0f 00 00       	mov    0xfac,%eax
{
 a9a:	89 e5                	mov    %esp,%ebp
 a9c:	57                   	push   %edi
 a9d:	56                   	push   %esi
 a9e:	53                   	push   %ebx
 a9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 aa2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 aa4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa7:	39 c8                	cmp    %ecx,%eax
 aa9:	73 15                	jae    ac0 <free+0x30>
 aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 aaf:	90                   	nop
 ab0:	39 d1                	cmp    %edx,%ecx
 ab2:	72 14                	jb     ac8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab4:	39 d0                	cmp    %edx,%eax
 ab6:	73 10                	jae    ac8 <free+0x38>
{
 ab8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aba:	8b 10                	mov    (%eax),%edx
 abc:	39 c8                	cmp    %ecx,%eax
 abe:	72 f0                	jb     ab0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac0:	39 d0                	cmp    %edx,%eax
 ac2:	72 f4                	jb     ab8 <free+0x28>
 ac4:	39 d1                	cmp    %edx,%ecx
 ac6:	73 f0                	jae    ab8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ac8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 acb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ace:	39 fa                	cmp    %edi,%edx
 ad0:	74 1e                	je     af0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ad2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ad5:	8b 50 04             	mov    0x4(%eax),%edx
 ad8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 adb:	39 f1                	cmp    %esi,%ecx
 add:	74 28                	je     b07 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 adf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 ae1:	5b                   	pop    %ebx
  freep = p;
 ae2:	a3 ac 0f 00 00       	mov    %eax,0xfac
}
 ae7:	5e                   	pop    %esi
 ae8:	5f                   	pop    %edi
 ae9:	5d                   	pop    %ebp
 aea:	c3                   	ret    
 aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 aef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 af0:	03 72 04             	add    0x4(%edx),%esi
 af3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 af6:	8b 10                	mov    (%eax),%edx
 af8:	8b 12                	mov    (%edx),%edx
 afa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 afd:	8b 50 04             	mov    0x4(%eax),%edx
 b00:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b03:	39 f1                	cmp    %esi,%ecx
 b05:	75 d8                	jne    adf <free+0x4f>
    p->s.size += bp->s.size;
 b07:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b0a:	a3 ac 0f 00 00       	mov    %eax,0xfac
    p->s.size += bp->s.size;
 b0f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b12:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b15:	89 10                	mov    %edx,(%eax)
}
 b17:	5b                   	pop    %ebx
 b18:	5e                   	pop    %esi
 b19:	5f                   	pop    %edi
 b1a:	5d                   	pop    %ebp
 b1b:	c3                   	ret    
 b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b20:	f3 0f 1e fb          	endbr32 
 b24:	55                   	push   %ebp
 b25:	89 e5                	mov    %esp,%ebp
 b27:	57                   	push   %edi
 b28:	56                   	push   %esi
 b29:	53                   	push   %ebx
 b2a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b30:	8b 3d ac 0f 00 00    	mov    0xfac,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b36:	8d 70 07             	lea    0x7(%eax),%esi
 b39:	c1 ee 03             	shr    $0x3,%esi
 b3c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b3f:	85 ff                	test   %edi,%edi
 b41:	0f 84 a9 00 00 00    	je     bf0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b47:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 b49:	8b 48 04             	mov    0x4(%eax),%ecx
 b4c:	39 f1                	cmp    %esi,%ecx
 b4e:	73 6d                	jae    bbd <malloc+0x9d>
 b50:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 b56:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b5b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b5e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 b65:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 b68:	eb 17                	jmp    b81 <malloc+0x61>
 b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b70:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 b72:	8b 4a 04             	mov    0x4(%edx),%ecx
 b75:	39 f1                	cmp    %esi,%ecx
 b77:	73 4f                	jae    bc8 <malloc+0xa8>
 b79:	8b 3d ac 0f 00 00    	mov    0xfac,%edi
 b7f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b81:	39 c7                	cmp    %eax,%edi
 b83:	75 eb                	jne    b70 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 b85:	83 ec 0c             	sub    $0xc,%esp
 b88:	ff 75 e4             	pushl  -0x1c(%ebp)
 b8b:	e8 4b fc ff ff       	call   7db <sbrk>
  if(p == (char*)-1)
 b90:	83 c4 10             	add    $0x10,%esp
 b93:	83 f8 ff             	cmp    $0xffffffff,%eax
 b96:	74 1b                	je     bb3 <malloc+0x93>
  hp->s.size = nu;
 b98:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b9b:	83 ec 0c             	sub    $0xc,%esp
 b9e:	83 c0 08             	add    $0x8,%eax
 ba1:	50                   	push   %eax
 ba2:	e8 e9 fe ff ff       	call   a90 <free>
  return freep;
 ba7:	a1 ac 0f 00 00       	mov    0xfac,%eax
      if((p = morecore(nunits)) == 0)
 bac:	83 c4 10             	add    $0x10,%esp
 baf:	85 c0                	test   %eax,%eax
 bb1:	75 bd                	jne    b70 <malloc+0x50>
        return 0;
  }
}
 bb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bb6:	31 c0                	xor    %eax,%eax
}
 bb8:	5b                   	pop    %ebx
 bb9:	5e                   	pop    %esi
 bba:	5f                   	pop    %edi
 bbb:	5d                   	pop    %ebp
 bbc:	c3                   	ret    
    if(p->s.size >= nunits){
 bbd:	89 c2                	mov    %eax,%edx
 bbf:	89 f8                	mov    %edi,%eax
 bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 bc8:	39 ce                	cmp    %ecx,%esi
 bca:	74 54                	je     c20 <malloc+0x100>
        p->s.size -= nunits;
 bcc:	29 f1                	sub    %esi,%ecx
 bce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 bd1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 bd4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 bd7:	a3 ac 0f 00 00       	mov    %eax,0xfac
}
 bdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bdf:	8d 42 08             	lea    0x8(%edx),%eax
}
 be2:	5b                   	pop    %ebx
 be3:	5e                   	pop    %esi
 be4:	5f                   	pop    %edi
 be5:	5d                   	pop    %ebp
 be6:	c3                   	ret    
 be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 bee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 bf0:	c7 05 ac 0f 00 00 b0 	movl   $0xfb0,0xfac
 bf7:	0f 00 00 
    base.s.size = 0;
 bfa:	bf b0 0f 00 00       	mov    $0xfb0,%edi
    base.s.ptr = freep = prevp = &base;
 bff:	c7 05 b0 0f 00 00 b0 	movl   $0xfb0,0xfb0
 c06:	0f 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c09:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 c0b:	c7 05 b4 0f 00 00 00 	movl   $0x0,0xfb4
 c12:	00 00 00 
    if(p->s.size >= nunits){
 c15:	e9 36 ff ff ff       	jmp    b50 <malloc+0x30>
 c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 c20:	8b 0a                	mov    (%edx),%ecx
 c22:	89 08                	mov    %ecx,(%eax)
 c24:	eb b1                	jmp    bd7 <malloc+0xb7>
