package data_structures;
  typedef logic [31:0] register_t;
  typedef logic [31:0] instruction_t;
  typedef logic [31:0] address_t;
  typedef logic [31:0] data_t;

  typedef logic [4:0] reg_addr_t;
  typedef logic [6:0] funct7_t;
  typedef logic [2:0] funct3_t;

  typedef enum logic [2:0] {
    OP = 0,
    OPI = 1,
    AUIPC = 2,
    BRANCH = 3,
    JUMP = 4,
    LOAD = 5,
    STORE = 6
  } inst_type_t;

  typedef enum logic [4:0] {
    ADD = 5'b00000,
    SUB = 5'b00001,
    XOR = 5'b00010,
    OR = 5'b00011,
    AND = 5'b00100,
    SLL = 5'b00101,
    SRL = 5'b00110,
    SRA = 5'b00111,
    SLT = 5'b01000,
    SLTU = 5'b01001,
    EQUAL = 5'b01010,
    NEQUAL = 5'b01011,
    GOET = 5'b01100,
    GETU = 5'b01101,
    PCP4 = 5'b01110,
    MUL = 5'b01111,
    MULH = 5'b10000,
    MULSU = 5'b10001,
    MULU = 5'b10010,
    DIV = 5'b10011,
    DIVU = 5'b10100,
    REM = 5'b10101,
    REMU = 5'b10110
  } aluop_t;



endpackage
