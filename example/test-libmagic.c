#include <magic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int Exit(char * c, int i);

int main(void) {

	char * TestPattern="Hello World\n";
	magic_t m;
	int ret_i;
	char * c;

	m    =magic_open(MAGIC_NONE); if (m==NULL)   { Exit("Err",1); }
	ret_i=magic_load(m,NULL);     if (ret_i==-1) { Exit("Error Load",1); }

	c= (char *) magic_buffer(m, TestPattern, strlen(TestPattern));
	if (c==NULL) { 
		Exit("E",2); 
	} else {
		printf("%s\n",c);
	}

	magic_close(m);

	exit(0);
}

int Exit(char * c, int i) {
	printf("%s\n",c);
	exit(i);
}

