PROJECT_HOME ?= $(shell pwd)
TOP_MODULE   ?= SimTop
DESIGN_DIR   ?= $(PROJECT_HOME)/src
BUILD_DIR    ?= $(PROJECT_HOME)/build
VSRC         ?= $(shell find $(PROJECT_HOME) -name "*.v" -or -name "*.sv")

include verilator.mk
	
clean:
	@echo "Clean build dir"
	rm -rf build