module Core
    import core_pkg::*;
(
   input  logic clock ,
   input  logic reset ,

   CC_if.CoProcessor CC
);

fetch_if fetchIF(clock, reset);

Fetch Fetch(fetchIF, CC);

endmodule
