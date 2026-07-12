import data_structures::*;

module branch_unit (
    input register_t rs1_i,
    input register_t pc_i,
	 
    input data_t aluout_i,
    input data_t imm_i,
	 
    input logic jump_c,
    input logic branch_c,
    input logic pcsource_c,

    output register_t pc_next_o
);
  data_t sum1 = 0, sum2 = 0;

  always_comb begin : branch_unit
    sum1 = (pcsource_c) ? rs1_i : pc_i; // MUDEI A ORDEM!!!
    sum2 = (jump_c || (branch_c && aluout_i[0])) ? imm_i : 32'(4);
    pc_next_o = (pcsource_c) ? ((sum1 + sum2) & 32'hFFFFFFFE) : (sum1+sum2);
  end
endmodule
