interface CC_if#(
    parameter type REQ_DATA_TYPE      = logic[127:0],
    parameter type RSP_DATA_TYPE      = logic[ 31:0],
    parameter type MEM_CMD_ADDR_TYPE  = logic[ 31:0],
    parameter type MEM_CMD_WDATA_TYPE = logic[ 31:0],
    parameter type MEM_CMD_SIZE_TYPE  = logic[  2:0],
    parameter type MEM_RSP_RDATA_TYPE = logic[ 31:0]
);

    // Request Channel
    logic         req_valid;
    logic         req_ready;
    REQ_DATA_TYPE req_data ;

    // Response Channel
    logic         rsp_valid;
    logic         rsp_ready;
    RSP_DATA_TYPE rsp_data ;
    logic         rsp_err  ;

    // Memory Request Channel
    logic              mem_cmd_valid;
    logic              mem_cmd_ready;
    MEM_CMD_ADDR_TYPE  mem_cmd_addr ;
    logic              mem_cmd_read ;
    MEM_CMD_WDATA_TYPE mem_cmd_wdata;
    MEM_CMD_SIZE_TYPE  mem_cmd_size ;

    // Memory Response Channel
    logic              mem_rsp_valid;
    logic              mem_rsp_ready;
    MEM_RSP_RDATA_TYPE mem_rsp_rdata;
    logic              mem_rsp_err  ;

    modport MasterProcessor(
        output req_valid,
        input  req_ready,
        output req_data ,

        input  rsp_valid,
        output rsp_ready,
        input  rsp_data ,
        input  rsp_err  
    );

    modport CoProcessor(
        input  req_valid,
        output req_ready,
        input  req_data ,

        output rsp_valid,
        input  rsp_ready,
        output rsp_data ,
        output rsp_err  
    );

endinterface
