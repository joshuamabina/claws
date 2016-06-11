# GNU Make unicorns.

# The main C++ compiler
CC = g++

# -Wall prints "all" warning messages.
# -g generates additional information for use with gdb.
# -std - compiles sources in both the C++03 and the C++11 standard.
CFLAGS += -Wall -g -std=c++0x -03

SRCDIR = src
BUILDDIR = build
TARGET = bin/claws

SRCEXT = cpp
SOURCES = $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS = $(patsubst $(SRCDIR)/%, $(BUILDDIR)/%, $(SOURCES: .$(SRCEXT)=.o))

# Include header files.
INC = -I include

# Include boost libraries.
LIBS += -L lib -lboost_program_options -lboost_filesystem -lboost_system

# Include opencv libraries.
CFLAGS += $(shell pkg-config --cflags opencv)
LIBS += $(shell pkg-config --libs opencv)

$(TARGET): $(OBJECTS)
	@echo " Linking..."
	@echo " $(CC) $^ -o $(TARGET) $(LIBS)"; $(CC) $^ -o $(TARGET) $(LIBS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<"; $(CC) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	@echo " Cleaning..."
	@echo " $(RM) -r $(BUILDDIR) $(TARGET)"; $(RM) -r $(BUILDDIR) $(TARGET)

#
# TODO: First solve the problem, then write the code.
#
tests:
	@echo " Pending..."

.PHONY: clean
