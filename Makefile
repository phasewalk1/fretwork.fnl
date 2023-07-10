SOURCES := $(shell find . -name '*.fnl')
OBJECTS := $(patsubst %.fnl, lib/%.lua, $(SOURCES))
MAINFNL = fun.fnl
BINARYOUTPUT = bin/fun

.PHONY: all clean bin

all: $(OBJECTS) 

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

