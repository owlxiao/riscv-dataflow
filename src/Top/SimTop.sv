module SimTop(
  input  logic i_clock,
  input  logic i_reset,
  output logic o_test 
);
  
  always_ff@(posedge i_clock or negedge i_reset) begin
    if (i_reset == 1'b0) begin 
      o_test <= 1'b0;
    end else begin 
      o_test <= o_test + 1'b1;
    end    
  end

endmodule
