#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <magic.h>
#include <string.h>

#include "const-c.inc"

MODULE = File::LibMagic		PACKAGE = File::LibMagic		

INCLUDE: const-xs.inc

PROTOTYPES: ENABLE

SV * magic_buffer(buffer)
       SV * buffer
       PREINIT:
         char * ret;
         int len,ret_i;
         magic_t m;
       CODE:
           m  =magic_open(MAGIC_NONE);
           if (m==NULL) { printf("Error at open\n"); }
           ret_i=magic_load(m,NULL);
           if (ret_i<0) { printf("Error at load\n"); }
           len=SvCUR(buffer);
           ret=(char*) magic_buffer(m,SvPV(buffer,len),len);
           magic_close(m);
           RETVAL = newSVpvn(ret, strlen(ret));
       OUTPUT:
          RETVAL

SV * magic_file(buffer)
       SV * buffer
       PREINIT:
         char * ret;
         int len,ret_i;
         magic_t m;
       CODE:
           m  =magic_open(MAGIC_NONE);
           if (m==NULL) { printf("Error at open\n"); }
           ret_i=magic_load(m,NULL);
           if (ret_i<0) { printf("Error at load\n"); }
           len=SvCUR(buffer);
           ret=(char*) magic_file(m,SvPV(buffer,len));
           magic_close(m);
           RETVAL = newSVpvn(ret, strlen(ret));
       OUTPUT:
          RETVAL
