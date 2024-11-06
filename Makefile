MODULES ?= queue
OUT_DIR ?= build

SOURCE_FILES=$(patsubst %,%.sv,$(MODULES))
TESTBENCH_FILES=$(patsubst %,%_tb.sv,$(MODULES))

.PHONY: all clean test

all: test

clean:
	rm -rf build

test: $(SOURCE_FILES) $(TESTBENCH_FILES)
	verilator --binary -j 0 --assert -Wall --Mdir $(OUT_DIR) -o $@ $^
	./$(OUT_DIR)/$@
