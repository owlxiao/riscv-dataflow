module SimTop(
  input  logic i_clock,
  input  logic i_reset
);

  core_if core_if(i_clock, i_reset);
  
  core u_core(core_if.Master);

endmodule
