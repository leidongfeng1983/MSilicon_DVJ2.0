#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
int main(int argc,char **argv)
{
	int fd;
	char *buffer;
	buffer = malloc(32 * 1024);
	if(buffer == NULL)
		exit(1);
	memset(buffer,1,32*1024);
	int i;
	fd = open("/dev/fram",O_RDWR);
	if(fd < 0){
		perror("open fram");
		exit(1);
	}
        printf("step1 \n");
	if(strcmp("read",argv[1]) == 0){
		if(read(fd,buffer,5) < 0){
			perror("read fram");
			exit(1);
		}
		for(i=0;i<5;i++)
			printf("%02hX ",buffer[i]);

	} else {
		for(i = 0;i <1024 ;i++){
			buffer[i] = (unsigned char)(((i & 0xfffff000) >> 12));
				buffer[i] = (unsigned char)(0xff);
	
				if((i & 0xfff) == 0){
					printf("%2x ",buffer[i]);
				}
		}
		putchar('\n');
		if(write(fd,buffer,1024) < 0){
			perror("write fram");
			exit(1);
		}
	}
        printf("\n");
	close(fd);
}
