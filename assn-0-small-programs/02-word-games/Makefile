#
# Makefile for Assignment 0, part 2
#

CC = g++
CFLAGS = -g -Wall
LDFLAGS = 
PURIFY = purify
PFLAGS=  -demangle-program=/usr/pubsw/bin/c++filt -linker=/usr/pubsw/bin/ld -best-effort  

SRCS = word-games.cc
HDRS = 
OBJS = word-games.o

EXECUTABLES = word-games
PURIFY_EXECUTABLES = word-games-pure

default: $(EXECUTABLES)

pure: $(PURIFY_EXECUTABLES)

word-games : Makefile.dependencies $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

word-games-pure : Makefile.dependencies $(OBJS)
	$(PURIFY) $(PFLAGS) $(CC) -o $@ $(OBJS) $(LDFLAGS)

# The dependencies below make use of make's default rules,
# under which a .o automatically depends on its .c and
# the action taken uses the $(CC) and $(CFLAGS) variables.
# These lines describe a few extra dependencies involved.

Makefile.dependencies:: $(SRCS) $(HDRS)
	$(CC) $(CFLAGS) -MM $(SRCS) > Makefile.dependencies

-include Makefile.dependencies

clean:
	\rm -fr a.out $(EXECUTABLES) $(PURIFY_EXECUTABLES) *.o core Makefile.dependencies
