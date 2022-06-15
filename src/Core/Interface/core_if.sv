interface core_if
    import core_pkg::*;
(
    input logic clock,
    input logic reset
);

modport Master (
    input clock,
    input reset
);
    
endinterface
