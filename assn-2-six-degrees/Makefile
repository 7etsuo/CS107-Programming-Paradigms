##
## Makefile for CS107 Assignment 2: Six Degrees
##

CPPFLAGS = -g -Wall
CXX = g++
LDFLAGS =

IMDB_CLASS = imdb.cc
IMDB_CLASS_H = $(IMDB_CLASS:.cc=.h)
IMDBTEST_SRCS = $(IMDB_CLASS) imdb-test.cc
IMDBTEST_OBJS = $(IMDBTEST_SRCS:.cc=.o)
IMDBTEST = imdb-test

MAINAPP_CLASS = $(IMDB_CLASS) path.cc
MAINAPP_CLASS_H = $(MAINAPP_CLASS:.cc=.h)
MAINAPP_SRCS = $(MAINAPP_CLASS) six-degrees.cc
MAINAPP_OBJS = $(MAINAPP_SRCS:.cc=.o)
MAINAPP = six-degrees

EXECUTABLES = $(IMDBTEST) $(MAINAPP) 

default : $(EXECUTABLES)

$(IMDBTEST) : $(IMDBTEST_OBJS)
	$(CXX) -o $(IMDBTEST) $(IMDBTEST_OBJS) $(LDFLAGS)

$(IMDBTEST)-pure : $(IMDBTEST_OBJS)
	purify $(CXX) -o $(IMDBTEST).purify $(IMDBTEST_OBJS) $(LDFLAGS)

$(MAINAPP) : $(MAINAPP_OBJS)
	$(CXX) -o $(MAINAPP) $(MAINAPP_OBJS) $(LDFLAGS)

clean : 
	/bin/rm -f *.o a.out $(IMDBTEST) $(IMDBTEST).purify $(MAINAPP) $(MAINAPP).purify core Makefile.dependencies

immaculate: clean
	rm -fr *~