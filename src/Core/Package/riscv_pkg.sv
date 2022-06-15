package riscv_pkg;

    localparam XLEN = 64;
    typedef logic[XLEN-1:0] xlen_t;

    localparam RV_INSTR_WIDTH = 32;

    localparam RV_REGISTER_NUM       = 32                     ;
    localparam RV_REGISTER_IDX_WIDTH = $clog2(RV_REGISTER_NUM);
    typedef logic[RV_REGISTER_IDX_WIDTH-1:0] rv_reg_idx_t     ;

    /// Base Instruction Formats
    localparam OPCODE_WIDTH = 7;
    typedef logic[RV_INSTR_WIDTH-1:0] instr_bits_t;

    typedef struct packed{
        logic[31:25] funct7;
        logic[24:20] rs2   ;
        logic[19:15] rs1   ;
        logic[14:12] funct3;
        logic[11:7 ] rd    ;
        logic[6 :0 ] opcode;
    }inst_r_type_t;


    typedef struct packed{
        logic[31:20] imm   ;
        logic[19:15] rs1   ;
        logic[14:12] funct3;
        logic[11:7 ] rd    ;
        logic[6 :0 ] opcode;
    }inst_i_type_t;

    typedef struct packed{
        logic[31:25] imm1  ;
        logic[24:20] rs2   ;
        logic[19:15] rs1   ;
        logic[14:12] funct3;
        logic[11:7 ] imm0  ;
        logic[6 :0 ] opcode;
    }inst_s_type_t;

    typedef struct packed{
        logic[31:25] imm1  ;
        logic[24:20] rs2   ;
        logic[19:15] rs1   ;
        logic[14:12] funct3;
        logic[11:7 ] imm0  ;
        logic[6 :0 ] opcode;
    }inst_b_type_t;

    typedef struct packed{
        logic[31:12] imm   ;
        logic[11:7 ] rd    ;
        logic[6 :0 ] opcode;
    }inst_u_type_t;

    typedef struct packed{
        logic[31:12] imm   ;
        logic[11:7 ] rd    ;
        logic[6 :0 ] opcode;
    }inst_j_type_t;

    typedef union packed{
        instr_bits_t  bits  ;
        inst_r_type_t r_type;
        inst_i_type_t i_type;
        inst_s_type_t s_type;
        inst_b_type_t b_type;
        inst_u_type_t u_type;
        inst_j_type_t j_type;
    }rv_inst_type_t;

    ///  RISC-V base opcode map
    enum logic[OPCODE_WIDTH-1:0] {
        OPCODE_LOAD     = 7'b00_000_11,
        OPCODE_STORE    = 7'b01_000_11,
        OPCODE_MADD     = 7'b10_000_11,
        OPCODE_BRANCH   = 7'b11_000_11,

        OPCODE_LOAD_FP  = 7'b00_001_11,
        OPCODE_STORE_FP = 7'b01_001_11,
        OPCODE_MSUB     = 7'b10_001_11,
        OPCODE_JALR     = 7'b11_001_11,

        OPCODE_CUSTOM_0 = 7'b00_010_11,
        OPCODE_CUSTOM_1 = 7'b01_010_11,
        OPCODE_NMSUB    = 7'b10_010_11,

        OPCODE_MISC_MEM = 7'b00_011_11,
        OPCODE_AM0      = 7'b01_011_11,
        OPCODE_NMADD    = 7'b10_011_11,
        OPCODE_JAL      = 7'b11_011_11,

        OPCODE_OP_IMM   = 7'b00_100_11,
        OPCODE_OP       = 7'b01_100_11,
        OPCODE_OP_FP    = 7'b10_100_11,
        OPCODE_SYSTEM   = 7'b11_100_11,

        OPCODE_AUIPC    = 7'b00_101_11,
        OPCODE_LUI      = 7'b01_101_11,

        OPCODE_OP_IMM_32= 7'b00_110_11,
        OPCODE_OP_32    = 7'b01_110_11,    
        OPCODE_CUSTOM_2 = 7'b10_110_11,
        OPCODE_CUSTOM_3 = 7'b11_110_11
    } rv_opcode_t;
    

    /// OPCODE Load
    enum logic[2:0] {
        LOAD_FUNC_LB  = 3'b000,
        LOAD_FUNC_LH  = 3'b001,
        LOAD_FUNC_LW  = 3'b010,
        LOAD_FUNC_LBU = 3'b100,
        LOAD_FUNC_LHU = 3'b101,
        // RV64I
        LOAD_FUNC_LWU = 3'b110,
        LOAD_FUNC_LD  = 3'b011
    } func_load_t;
    

    /// OPCODE Store
    enum logic[2:0] {
        FUNC_STORE_SB = 3'b000,
        FUNC_STORE_SH = 3'b001,
        FUNC_STORE_SW = 3'b010,
        // RV64I
        FUNC_STORE_SD = 3'b011
    } func_store_t;
    

    /// OPCODE Branch
    enum logic[2:0] {
        FUNC_BRANCH_BEQ  = 3'b000,
        FUNC_BRANCH_BNE  = 3'b001,
        FUNC_BRANCH_BLT  = 3'b100,
        FUNC_BRANCH_BGE  = 3'b101,
        FUNC_BRANCH_BLTU = 3'b110,
        FUNC_BRANCH_BGEU = 3'b111
    } func_branch_t;

    /// OPCODE OP IMM
    enum logic[2:0] {
        FUNC_OP_IMM_ADDI      = 3'b000,
        FUNC_OP_IMM_SLTI      = 3'b010,
        FUNC_OP_IMM_SLTIU     = 3'b011,
        FUNC_OP_IMM_XORI      = 3'b100,
        FUNC_OP_IMM_ORI       = 3'b110,
        FUNC_OP_IMM_ANDI      = 3'b111,
        //RV32/64I
        FUNC_OP_IMM_SLLI      = 3'b001,
        FUNC_OP_IMM_SRLI_SRAI = 3'b101
    } func_op_imm_t;

    /// OPCODE OP
    enum logic[2:0] {
        FUNC_OP_ADD_SUB = 3'b000,
        FUNC_OP_SLL     = 3'b001,
        FUNC_OP_SLT     = 3'b010,
        FUNC_OP_SLTU    = 3'b011,
        FUNC_OP_XOR     = 3'b100,
        FUNC_OP_SRL_SRA = 3'b101,
        FUNC_OP_OR      = 3'b110,
        FUNC_OP_AND     = 3'b111
    } func_op_t;

    /// OPCODE MISC_MEM
    enum logic[2:0] {
        FUNC_MISC_MEM_FENCE = 3'b000
    } func_misc_mem_t;

    /// SYSTEM
    enum logic[2:0] {
        FUNC_SYSTEM_ECALL_EBREAK = 3'b000
    } func_system_t;

    /// OPCODE OP IMM 32
    enum logic[2:0] {
        RV64I_OP_IMM_32_FUNC_ADDIW       = 3'b000,
        RV64I_OP_IMM_32_FUNC_SLLIW       = 3'b001,
        RV64I_OP_IMM_32_FUNC_SRLIW_SRAIW = 3'b101
    } func_imm_32_t;

    /// OPCODE OP 32
    enum logic[2:0] {
        FUNC_OP_32_ADDW_SUBW = 3'b000,
        FUNC_OP_32_SLLW      = 3'b001,
        FUNC_OP_32_SRLW_SRAW = 3'b101
    } func_op_32_t;

    typedef struct packed {
        logic LUI   ;
        logic AUIPC ;
        logic JAL   ;
        logic JALR  ;
        logic BEQ   ;
        logic BNE   ;
        logic BLT   ;
        logic BGE   ;
        logic BLTU  ;
        logic BGEU  ;
        logic LB    ;
        logic LH    ;  
        logic LW    ;   
        logic LBU   ;
        logic LHU   ;
        logic SB    ;
        logic SH    ;
        logic SW    ;
        logic ADDI  ;
        logic SLTI  ;
        logic SLTIU ;    
        logic XORI  ;
        logic ORI   ;
        logic ANDI  ;
        logic SLLI  ;
        logic SRLI  ;
        logic SRAI  ;
        logic ADD   ;
        logic SUB   ;
        logic SLL   ;
        logic SLT   ;
        logic SLTU  ;
        logic XOR   ;
        logic SRL   ;
        logic SRA   ;
        logic OR    ;
        logic AND   ;
        logic FENCE ;
        logic ECALL ;
        logic EBREAK;    
    } rv_instr_set_t;

endpackage
