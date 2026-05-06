import data_structures::*;

module alu (
    input data_t  alusrc_1_i,
    input data_t  alusrc_2_i,
    input aluop_t aluop_i,

    output data_t aluout_o
);

  always_comb begin
    aluout_o = 0;
    case (aluop_i)
      ADD:                   aluout_o = alusrc_1_i + alusrc_2_i;
      SUB:                   aluout_o = alusrc_1_i - alusrc_2_i;
      LESS_THAN:             aluout_o = ($signed(alusrc_1_i) < $signed(alusrc_2_i)) ? 1 : 0;
      LESS_THAN_UNSIGNED:    aluout_o = (alusrc_1_i < alusrc_2_i) ? 1 : 0;
      GREATER_THAN:          aluout_o = ($signed(alusrc_1_i) > $signed(alusrc_2_i)) ? 1 : 0;
      GREATER_THAN_UNSIGNED: aluout_o = (alusrc_1_i > alusrc_2_i) ? 1 : 0;
      XOR:                   aluout_o = alusrc_1_i ^ alusrc_2_i;
      OR:                    aluout_o = alusrc_1_i | alusrc_2_i;
      AND:                   aluout_o = alusrc_1_i & alusrc_2_i;
      SLL:                   aluout_o = alusrc_1_i << alusrc_2_i[4:0];
      SRL:                   aluout_o = alusrc_1_i >> alusrc_2_i[4:0];
      SRA:                   aluout_o = $signed(alusrc_1_i) >>> alusrc_2_i[4:0];
      EQUAL:                 aluout_o = $signed(alusrc_1_i) == $signed(alusrc_2_i);
      INCREMENT_PC:          aluout_o = alusrc_1_i + 4;
      default: begin

      end
    endcase
  end
endmodule
