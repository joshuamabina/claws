# GNU Make unicorns.

# The main C++ compiler
CC = g++

#Choosing the Shell
SHELL = /bin/bash

# -Wall prints "all" warning messages.
# -g generates additional information for use with gdb.
# -std - compiles sources in both the C++03 and the C++11 standard.
CFLAGS += -Wall -g -std=c++0x -O3

APP_NAME = claws
SOURCE_EXT = cpp

SOURCE = src
BUILD = build
INCLUDE = include
TARGET = $(BUILD)/bin

SOURCES = $(shell find $(SOURCE) -type f -name *.$(SOURCE_EXT))
OBJECTS = $(patsubst $(SOURCE)/%,$(BUILD)/%,$(SOURCES:.$(SOURCE_EXT)=.o))

# Include boost libraries.
LIBS += -L lib -lboost_program_options -lboost_filesystem -lboost_system -lexiv2

# Include opencv libraries.
CFLAGS += $(shell pkg-config --cflags opencv)
LIBS += $(shell pkg-config --libs opencv)

$(TARGET): $(OBJECTS)
	@echo ""
	@echo " Linking..."
	@mkdir -p $(TARGET)
	@echo " $(CC) $^ -o $(TARGET)/$(APP_NAME) $(LIBS)"; $(CC) $^ -o $(TARGET)/$(APP_NAME) $(LIBS)
	@echo ""
	@echo " Symlinking..."
	@echo " $(TARGET)/$(APP_NAME)"
	@ln -sf $(TARGET)/$(APP_NAME) ./$(APP_NAME)

$(BUILD)/%.o: $(SOURCE)/%.$(SOURCE_EXT)
	@echo ""
	@echo " Building..."
	@mkdir -p $(BUILD)
	@echo " $(CC) $(CFLAGS) -I $(INCLUDE) -c -o $@ $<"; $(CC) $(CFLAGS) -I $(INCLUDE) -c -o $@ $<

clean:
	@echo ""
	@echo " Cleaning..."
	@echo " $(RM) -r $(BUILD) $(TARGET)/$(APP_NAME)"; $(RM) -r $(BUILD) $(TARGET)/$(APP_NAME)

#
# TODO: First solve the problem, then write the code.
#
tests:
	@echo " Pending..."

.PHONY: clean
