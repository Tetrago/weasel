MODULES ?= queue alu
OUT_DIR ?= build

SOURCE_FILES=$(patsubst %,%.sv,$(MODULES))
TESTBENCH_FILES=$(patsubst %,%_tb.sv,$(MODULES))

.PHONY: all clean test

all: test

clean:
	rm -rf build

%_tb: $(SOURCE_FILES)
	verilator --binary -j 0 --assert -Wall --Mdir $(OUT_DIR) -o $@ --top-module $@ $^ $@.sv
	./$(OUT_DIR)/$@

test: $(patsubst %_tb.sv,%_tb,$(TESTBENCH_FILES))
