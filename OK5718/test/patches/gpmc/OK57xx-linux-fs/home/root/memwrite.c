#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <ctype.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/mman.h>
  
#define FATAL do { fprintf(stderr, "Error at line %d, file %s (%d) [%s]\n", \
  __LINE__, __FILE__, errno, strerror(errno)); exit(1); } while(0)
 
#define MAP_SIZE   0x1000000  
#define MAP_MASK   (MAP_SIZE - 1)

unsigned int buffer[MAP_SIZE] = {0};

int main(int argc, char **argv) 
{
    int fd;
    void *map_base, *virt_addr; 
    unsigned long lengthl = 0;
    unsigned long i,writeval;
    unsigned char  *virt_char;
    unsigned short *virt_short;
    unsigned int   *virt_point;
    off_t target;
    int access_type = 'w';
    
    if(argc < 2) {
        fprintf(stderr, "\nUsage:\t%s { address } [ type [ data ] ]\n"
            "\taddress : memory address to act upon\n"
            "\ttype    : access operation type : [b]yte, [h]alfword, [w]ord\n"
            "\tdata    : data to be written\n\n",
            argv[0]);
        exit(1);
    }
    target = strtoul(argv[1], 0, 0);

    if(argc > 2)
        access_type = tolower(argv[2][0]);
    
    if((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) FATAL;
    printf("/dev/mem opened.\n"); 
    fflush(stdout);
    
    /* Map one page */
    map_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target & ~MAP_MASK);
    if(map_base == (void *) -1) FATAL;
    printf("Memory mapped at address %p.\n", map_base); 
    fflush(stdout);
    
    writeval = strtoul(argv[3], 0, 0);
    virt_addr = map_base + (target & MAP_MASK);  /* (target & MAP_MASK) == 0 */
    *((unsigned char *) virt_addr) = writeval;
   
    if(munmap(map_base, MAP_SIZE) == -1) FATAL;
    close(fd);
    return 0;
}
