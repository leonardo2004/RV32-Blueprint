import data_structures::*;

module immediate_generator (
    input instruction_t inst_i,
    input inst_type_t   inst_type_c,

    output data_t imm_o
);


  always_comb begin : immediate_generator
    imm_o = 0;
    case (inst_type_c)
      OPI:  imm_o = 32'(signed'(inst_i[31:20]));
      LOAD: imm_o = 32'(signed'(inst_i[31:20]));

      AUIPC: imm_o = {inst_i[31:12], 12'b000000000000};

      STORE: imm_o = 32'(signed'({inst_i[31:25], inst_i[11:7]}));

      BRANCH: imm_o = 32'(signed'({inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0}));

      JUMP:
      imm_o = 32'(signed'({
        inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0
      }));

      default: begin
      end
    endcase
  end

endmodule
