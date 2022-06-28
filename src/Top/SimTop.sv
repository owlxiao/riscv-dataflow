module SimTop(
  input  logic i_clock,
  input  logic i_reset
);

  CC_if  CC();
  
  Core u_core(i_clock, i_reset, CC);

endmodule
