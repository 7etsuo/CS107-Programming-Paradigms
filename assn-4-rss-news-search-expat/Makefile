##
## Makefile for our RSS News Feed Aggregator
##

## Set the compiler to be a known ANSI compliant one
CC = gcc

## adding the '-DNDEBUG' defines the CT symbol NDEBUG which
## suppresses all the asserts and what not. You'd do that for
## a production build, but it is a good idea to leave it in
## for the purposes of this class.
DFLAG = ## -DNDEBUG

ifeq ($(OSTYPE), solaris)
	SOCKETLIB = -lsocket
endif

CFLAGS = -g -Wall -std=gnu99 -Wno-unused-function $(DFLAG)
LDFLAGS = -g $(SOCKETLIB) -lexpat -lnsl -lrssnews -L/usr/class/cs107/assignments/assn-4-rss-news-search-lib/$(OSTYPE)
PFLAGS= -linker=/usr/pubsw/bin/ld -best-effort

SRCS = rss-news-search.c
OBJS = $(SRCS:.c=.o)
TARGET = rss-news-search
TARGET-PURE = rss-news-search.purify

default : $(TARGET)

rss-news-search : $(OBJS)
	$(CC) $(OBJS) $(CFLAGS)$(LDFLAGS) -o $@

pure : $(TARGET-PURE)

rss-news-search.purify : $(OBJS)
	purify -cache-dir=/tmp $(PFLAGS) $(CC) $(OBJS) $(CFLAGS)$(LDFLAGS) -o $@

# The dependencies below make use of make's default rules,
# under which a .o automatically depends on its .c and
# the action taken uses the $(CC) and $(CFLAGS) variables.
# These lines describe a few extra dependencies involved

clean : 
	@echo "Removing all object files..."
	/bin/rm -f *.o a.out core $(TARGET) $(TARGET-PURE)

TAGS : $(SRCS) $(HDRS)
	etags -t $(SRCS) $(HDRS)
