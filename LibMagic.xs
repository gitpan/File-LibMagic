#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <magic.h>
#include <string.h>

#include "const-c.inc"

/* I don't know anything about perlxs, just trying by best. ;(
*/

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
           m  =magic_open(MAGIC_NONE); if (m==NULL) { printf("Error at open\n"); }
           ret_i=magic_load(m,NULL);   if (ret_i<0) { printf("Error at load\n"); }
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
           m  =magic_open(MAGIC_NONE); if (m==NULL) { printf("Error at open\n"); }
           ret_i=magic_load(m,NULL);   if (ret_i<0) { printf("Error at load\n"); }
           len=SvCUR(buffer);
           ret=(char*) magic_file(m,SvPV(buffer,len));
           magic_close(m);
           RETVAL = newSVpvn(ret, strlen(ret));
       OUTPUT:
          RETVAL

IV   magic_open(flags)
       int flags
       PREINIT:
       	    magic_t m;
       CODE:
             m=magic_open(flags);
	     RETVAL=(int) m;
       OUTPUT:
       	     RETVAL

void magic_close(handle) 
	int handle
	PREINIT:
		magic_t m;
	CODE:
		m=(magic_t) handle;
		magic_close(m);

IV   magic_load(handle,dbnames)
	int handle
	SV * dbnames
	PREINIT:
		magic_t m;
		int ret;
	CODE:
		m=(magic_t) handle;
		// ret=magic_load(m,SvPV(dbnames,SvCUR(dbnames)));
		ret=magic_load(m,NULL);
		RETVAL=ret;
	OUTPUT:
		RETVAL


SV * mb(handle,buffer)
	int handle
	SV * buffer
	PREINIT:
		magic_t m;
		char * ret;
		int len;
	CODE:
		m=(magic_t) handle;
           	len=SvCUR(buffer);
		ret=(char*) magic_buffer(m,SvPV(buffer,len),len);
           	RETVAL = newSVpvn(ret, strlen(ret));
	OUTPUT:
		RETVAL

