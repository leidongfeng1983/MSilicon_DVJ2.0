#include<sys/mman.h>
#include<sys/types.h>
#include<fcntl.h>
#include<string.h>
#include<stdio.h>
#include<unistd.h>
void main(int argc,char **argv)
{
    int gpio_fd, ip=0, i=0; 
    unsigned char *gpio_map; 
    gpio_map = NULL; 

    gpio_fd =open("/dev/mem",O_RDWR); 
    if (gpio_fd == -1) 
    { 
        printf("can't open /dev/mem.\n"); 
        return ; 
    }

    gpio_map = (unsigned char *)mmap(0, 0xbc,PROT_READ | PROT_WRITE, MAP_SHARED,gpio_fd, 0x0a000000); 
    printf("Good Bill!\n");
    *(volatile unsigned int*)(gpio_map+0x7ffe0)=0x02;
    //printf("%d\n",(volatile unsigned char *)(gpio_map));
    //printf("%d\n",*(gpio_map+0x7fff4));
    //printf("%d\n",*(gpio_map+0x7fff6));
}
