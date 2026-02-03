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
    LOAD      = 0000011,
    LOAD_FP   = 0000111,
    CUSTOM_0  = 0001011,
    MISC_MEM  = 0001111,
    OP_IMM    = 0010011,
    AUIPC     = 0010111,
    OP_IMM_32 = 0011011,

    STORE     = 0100011,
    STORE_FP  = 0100111,
    CUSTOM_1  = 0101011,
    AMO       = 0101111,
    OP        = 0110011,
    LUI       = 0110111,
    OP_32     = 0111011,

    MADD      = 1000011,
    MSUB      = 1000111,
    NMSUB     = 1001011,
    NMADD     = 1001111,
    OP_FP     = 1010011,

    BRANCH    = 1100011,
    JALR      = 1100111,
    JAL       = 1101111,
    SYSTEM    = 1110011
  } opcode_t;


endpackage
