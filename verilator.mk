# Sim CXX
SIM_CXX_DIR   = $(DESIGN_DIR)/
SIM_CXX_FILES = $(shell find $(SIM_CXX_DIR) -name "*.cpp")
SIM_CXX_FLAGS = -std=c++17 -Wall -I$(SIM_CXX_DIR)

VEXTRA_FLAGS += -O3 -CFLAGS "$(SIM_CXX_FLAGS)" 

# Verilator trace support 
VTRACE ?= 
ifeq ($(VTRACE), 1)
VEXTRA_FLAGS += --trace
SIM_CXX_FLAGS += -DSIM_TRACE
endif

# Verilator multi-thread support 
VTHREADS ?= 0
ifneq ($(VTHREADS), 0)
VEXTRA_FLAGS += --threads $(VTHREADS) --threads-dpi all
SIM_CXX_FLAGS += -lpthread
SIM_CXX_FLAGS += -DSIM_THREADS
endif

VERILATOR_FLAGS =              \
	-Wall                      \
	--compiler clang           \
	-sv                        \
	--top-module $(TOP_MODULE) \
	-f $(PROJECT_HOME)/src/Source.list \
	$(SIM_CXX_FILES)           \
	$(VEXTRA_FLAGS)            \
	--output-split 30000       \
	

VLINT: $(VSRC)
	@echo "[Verilator] Generating C++ files"
	
	verilator --lint-only      \
	$(VERILATOR_FLAGS)         \

VSIM: $(VSRC) $(SIM_CXX_FILES)
	@echo "[Verilator] Translate the design into C++ files"

	verilator -cc -exe  \
	-Mdir $(BUILD_DIR)  \
	$(VERILATOR_FLAGS)  \

	@echo "[Make] Compiling C++ files"
	
	make CXX=clang++ LINK=clang++ -j VM_PARALLEL_BUILDS=1 OPT_FAST="-O3" \
		-C $(BUILD_DIR) -f V$(TOP_MODULE).mk

VSIM_RUN:
	cd $(BUILD_DIR) && ./V$(TOP_MODULE)


	

