#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
int main()
{
	for(long long int i=0;i<10000000000;i++)
	{
		if(i%100000000 == 0)
		printf("NO\n");
	}
}
