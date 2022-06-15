#include "VSimTop.h"
#include "VSimTop__Syms.h"
#include <verilated_vcd_c.h>
#ifdef SIM_THREADS
#include <verilated_threads.h>
#endif

#include <iostream>
#include <memory>

#define RESET_CYCLES(C)                                                        \
  for (std::size_t i = 0; i < C; ++i) {                                        \
    SimTop->i_reset = 0;                                                       \
    SimTop->i_clock = 1;                                                       \
    SimTop->eval();                                                            \
    SimTop->i_clock = 1;                                                       \
    SimTop->eval();                                                            \
    SimTop->i_reset = 1;                                                       \
  }

int main(int argc, const char **argv) {
  Verilated::commandArgs(argc, argv);

  std::unique_ptr<VSimTop> SimTop = std::make_unique<VSimTop>();
  std::size_t cycle_cnt = 0;

  RESET_CYCLES(10)

#ifdef SIM_TRACE
  Verilated::traceEverOn(true);
  std::unique_ptr<VerilatedVcdC> tfp = std::make_unique<VerilatedVcdC>();
  SimTop->trace(tfp.get(), 99);
  tfp->open("SimTop.vcd");
#endif

  for (; !Verilated::gotFinish() && (cycle_cnt != 10000); ++cycle_cnt) {
    SimTop->i_clock = 0;
    SimTop->eval();

#ifdef SIM_TRACE
    tfp->dump(cycle_cnt);
#endif

    SimTop->i_clock = 1;
    SimTop->eval();
    std::cout << "SimTop OUT: " << static_cast<int>(SimTop->o_test) << "\n";
  }

#ifdef SIM_TRACE
  tfp->close();
#endif
  return 0;
}