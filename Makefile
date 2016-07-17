
version=0.1

CFLAGS+=-Wall -Wextra
CFLAGS+=-std=c11
CFLAGS+=-D_XOPEN_SOURCE=700
CFLAGS+=-DJB_VERSION=${version}

# For NetBSD build:
CFLAGS+=-I/usr/X11R6/include
CFLAGS+=-I/usr/X11R7/include
LDFLAGS+=-L/usr/X11R6/lib -Wl,-R/usr/X11R6/lib
LDFLAGS+=-L/usr/X11R7/lib -Wl,-R/usr/X11R7/lib
# Libs:
LDFLAGS+=-lxcb
PREFIX=/usr
prog=xstatus
objs=util.o

installdir=${DESTDIR}${PREFIX}

all: libjb.a ${objs}
	ls -l libjb.a >> sz.log; tail sz.log

libjb.a: ${objs}
	ar rcs libjb.a ${objs}

*.h:
	make clean

${objs}: *.h

clean:
	rm -f libjb.a *.o

install:
	install -d /usr/lib
	install -d /usr/include/jb
	install libjb.a /usr/lib
	install jb.h /usr/include
