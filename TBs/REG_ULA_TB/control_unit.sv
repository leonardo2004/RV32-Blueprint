import data_structures::*;

module control_unit (
    input instruction_t inst_i,

    output inst_type_t inst_type_c,

    output logic memwrite_c,
    memread_c,
    alusel1_c,
    alusel2_c,
    we_c,
    memtoreg_c,
    lui_c,
    branch_c,
    jump_c,
    pcsource_c

);

  opcode_t opcode;
  assign opcode = opcode_t'(inst_i[6:0]);

  always_comb begin : control_unit
    memwrite_c = 0;
    memread_c = 0;
    alusel1_c = 0;
    alusel2_c = 0;
    we_c = 0;
    memtoreg_c = 0;
    lui_c = 0;
    branch_c = 0;
    jump_c = 0;
    pcsource_c = 0;

    inst_type_c = OP;
    case (opcode)
      opcode_OP: begin
        we_c = 1;
      end
      opcode_OP_IMM: begin
        alusel2_c = 1;
        we_c = 1;

        inst_type_c = OPI;
      end
      opcode_LOAD: begin
        memread_c = 1;
        alusel2_c = 1;
        we_c = 1;
        memtoreg_c = 1;

        inst_type_c = LOAD;
      end
      opcode_STORE: begin
        memwrite_c  = 1;
        alusel2_c   = 1;

        inst_type_c = STORE;
      end
      opcode_BRANCH: begin
        branch_c = 1;

        inst_type_c = BRANCH;
      end
      opcode_JAL: begin
        alusel1_c = 1;
        we_c = 1;
        jump_c = 1;

        inst_type_c = JUMP;
      end
      opcode_JALR: begin
        alusel1_c = 1;
        we_c = 1;
        jump_c = 1;
        pcsource_c = 1;

        inst_type_c = JUMP;
      end
      opcode_LUI: begin
        we_c  = 1;
        lui_c = 1;

      end
      opcode_AUIPC: begin
        alusel1_c = 1;
        alusel2_c = 1;
        we_c = 1;

        inst_type_c = AUIPC;
      end
      default: begin
      end
    endcase

  end
endmodule
