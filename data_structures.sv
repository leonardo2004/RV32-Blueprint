package data_structures;
  typedef logic [31:0] register_t;
  typedef logic [31:0] instruction_t;
  typedef logic [31:0] address_t;
  typedef logic [31:0] data_t;

  typedef logic [4:0] reg_addr_t;
  typedef logic [6:0] funct7_t;
  typedef logic [2:0] funct3_t;

  typedef enum logic [6:0] {
    // [1:0] == 2'b11
    // https://five-embeddev.com/riscv-user-isa-manual/Priv-v1.12/opcode-map.html
    // Por questão de preguiça, copiei todos e vou implementar o que for usado
    // no RV32I
    LOAD      = 7'b0000011,
    LOAD_FP   = 7'b0000111,
    CUSTOM_0  = 7'b0001011,
    MISC_MEM  = 7'b0001111,
    OP_IMM    = 7'b0010011,
    AUIPC     = 7'b0010111,
    OP_IMM_32 = 7'b0011011,

    STORE     = 7'b0100011,
    STORE_FP  = 7'b0100111,
    CUSTOM_1  = 7'b0101011,
    AMO       = 7'b0101111,
    OP        = 7'b0110011,
    LUI       = 7'b0110111,
    OP_32     = 7'b0111011,

    MADD      = 7'b1000011,
    MSUB      = 7'b1000111,
    NMSUB     = 7'b1001011,
    NMADD     = 7'b1001111,
    OP_FP     = 7'b1010011,

    BRANCH    = 7'b1100011,
    JALR      = 7'b1100111,
    JAL       = 7'b1101111,
    SYSTEM    = 7'b1110011
  } opcode_t;


  typedef enum logic [3:0] {
    ADD     = 4'b0000,
    SUB     = 4'b0001,
    LT      = 4'b0010,
    LTU     = 4'b0011,
    GT      = 4'b0100,
    GTU     = 4'b0101,
    XOR     = 4'b0110,
    OR      = 4'b0111,
    AND     = 4'b1000,
    SLL     = 4'b1001,
    SRL     = 4'b1010,
    SRA     = 4'b1011,
    EQUAL   = 4'b1100,
    NEQUAL  = 4'b1101,
    INC_PC  = 4'b1110

    } aluop_t;

endpackage
