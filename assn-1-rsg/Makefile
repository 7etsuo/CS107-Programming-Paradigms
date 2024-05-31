##
## Makefile for CS107 Assignment 1: Random Sentence Generator
##

CPPFLAGS = -g -Wall

CXX = g++
LDFLAGS = 

CLASS = random.cc production.cc definition.cc
CLASS_H = $(SRCS:.cc=.h)
SRCS = rsg.cc $(CLASS)
OBJS = $(SRCS:.cc=.o)
PROGS = rsg

default : $(PROGS) 

$(PROGS) : depend $(OBJS)
	$(CXX) -o $@ $(OBJS)   $(LDFLAGS) 

# The dependencies below make use of make's default rules,
# under which a .o automatically depends on its .c and
# the action taken uses the $(CC) and $(CFLAGS) variables.
# These lines describe a few extra dependencies involved.

depend:: Makefile.dependencies $(SRCS) $(HDRS)

Makefile.dependencies:: $(SRCS) $(HDRS)
	$(CXX) $(CPPFLAGS) -MM $(SRCS) > Makefile.dependencies

-include Makefile.dependencies

clean : 
	/bin/rm -f *.o a.out core $(PROGS) Makefile.dependencies

TAGS : $(SRCS) $(HDRS)
	etags -t $(SRCS) $(HDRS)
