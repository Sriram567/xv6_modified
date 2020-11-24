#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"

int main(int argc, char * argv[])
{
	int pid;
	int  waittime = 0, runtime = 0;

	pid = fork();

	if(pid < 0)
	{
		printf(1,"fork failed\n");
	}
	else if(pid == 0)
	{
		exec(argv[1], argv+1);
	}
	else
	{
//		status  =
		       	waitx(&waittime , &runtime);

		printf(1, "The process WAIT TIME = %d RUN TIME = %d\n ", waittime, runtime);
	}
	exit();
	

}
