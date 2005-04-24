test-libmagic: test-libmagic.c
	gcc $< -o $@ -Wall -lmagic
pointersize:	pointersize.c
	gcc $< -o $@ -Wall -lmagic

clean distclean:
	rm -f pointersize test-libmagic
