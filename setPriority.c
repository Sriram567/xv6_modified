#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"

int main(int argc, char * argv[])
{
	int pid = atoi(argv[2]);
	int new_priority = atoi(argv[1]);

	set_priority(new_priority, pid);
	exit();

}
