package core_pkg;
    import riscv_pkg::*;

    /// Program Counter 
    localparam CORE_PC_WIDTH       = 32       ;
    typedef logic[CORE_PC_WIDTH-1:0] core_pc_t;

    /// Address Width
    localparam CORE_ADDR_WIDTH       = 32               ;
    typedef logic[CORE_ADDR_WIDTH-1:0] core_addr_t      ;
    typedef core_addr_t                core_fetch_addr_t;
    typedef core_addr_t                core_lsu_addr_t  ;

    /// Instruction Packet from master processors
    localparam CORE_INSTR_SINGLE_WIDTH         = RV_INSTR_WIDTH                                 ;
    localparam CORE_INSTR_PACKET_NUM           = 4                                              ;
    localparam CORE_INSTR_PACKET_WIDTH         = CORE_INSTR_SINGLE_WIDTH * CORE_INSTR_PACKET_NUM;
    typedef logic[CORE_INSTR_SINGLE_WIDTH-1:0] core_sinstr_t                                    ;
    typedef logic[CORE_INSTR_PACKET_WIDTH-1:0] core_instr_packet_t                              ;
    
endpackage
