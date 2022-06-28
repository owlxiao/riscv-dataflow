interface fetch_if
    import core_pkg::*;
(
    input logic clock   ,
    input logic reset   
);
    logic               fetch_iw_valid        ;
    logic               iw_fetch_ready        ;
    core_instr_packet_t fetch_iw_instr_packet ;

    modport Fetch(
        input clock                 ,
        input reset                 ,

        output fetch_iw_valid       ,
        input  iw_fetch_ready       ,
        output fetch_iw_instr_packet
    );

    modport Next(
        input  fetch_iw_valid       ,
        output iw_fetch_ready       ,
        input  fetch_iw_instr_packet
    );


endinterface
