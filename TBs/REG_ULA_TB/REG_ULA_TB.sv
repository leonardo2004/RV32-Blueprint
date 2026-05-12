import data_structures::*;

module REG_ULA_TB ();

  logic
      clk_c,
      RESET;
  data_t rdata_o, aluout_o, imm_o;
  instruction_t inst_o;
  register_t rs1_o, rs2_o, pc;

  integ integ (
      //Entradas
      .clk_c(clk_c),
      .RESET(RESET),

      //Saídas
      .aluout_o(aluout_o),
      .imm(imm_o),
      .rs1_o(rs1_o),
      .rs2_o(rs2_o),
      .rdata_o(rdata_o),
      .pc(pc),
      .inst_o(inst_o)
  );

  always #5 clk_c = !clk_c;

  initial begin
    RESET = 0;clk_c = 0;
    #10;
    RESET = 1;
    //ADDI x1, x, 1 -> 00000000000100000000000010010011 -> 00100093
    $display("Primeira instrução: ADDI x1, x0, 1");
    #1400;
    $finish;
  end
endmodule
