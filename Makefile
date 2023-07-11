DESTDIR := $(HOME)/.config/fun
BINARYDESTDIR := $(HOME)/.local/bin
LIBDESTDIR := $(HOME)/.config/fun/lib
MAINFNL = main.fnl
BINARYOUTPUT = $(BINARYDESTDIR)/fun

SOURCES := $(shell find . -name '*.fnl')
OBJECTS := $(patsubst %.fnl, lib/%.lua, $(SOURCES))


.PHONY: all clean bin

all: $(OBJECTS) $(BINARYOUTPUT)

install: $(OBJECTS) $(BINARYOUTPUT)
	mkdir -p $(DESTDIR)
	mkdir -p $(LIBDESTDIR)
	cp $(BINARYOUTPUT) $(BINARYDESTDIR)
	cp -r $(OBJECTS) $(LIBDESTDIR})

clean:
	rm -rf lib
	rm -rf bin

lib/%.lua: %.fnl
	mkdir -p $(dir $@)
	fennel --compile $< > $@

$(BINARYOUTPUT): $(MAINFNL)
	mkdir -p bin
	echo "#!/usr/bin/env lua" > $(BINARYOUTPUT)
	fennel --require-as-include --compile $(MAINFNL) >> $(BINARYOUTPUT)
	chmod 755 $(BINARYOUTPUT)

bin: $(BINARYOUTPUT)

