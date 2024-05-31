#
# Makefile for Assignment 0, part 1
#

CC = gcc
CFLAGS = -g -Wall
LDFLAGS = -lm
PURIFY = purify
PFLAGS=  -demangle-program=/usr/pubsw/bin/c++filt -linker=/usr/pubsw/bin/ld -best-effort  

SRCS = ruth-aaron-numbers.c
HDRS = 
OBJS = ruth-aaron-numbers.o

EXECUTABLES = ruth-aaron-numbers
PURIFY_EXECUTABLES = ruth-aaron-numbers-pure

default: $(EXECUTABLES)

pure: ruth-aaron-numbers-pure

ruth-aaron-numbers : Makefile.dependencies $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

ruth-aaron-numbers-pure : Makefile.dependencies $(OBJS)
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
