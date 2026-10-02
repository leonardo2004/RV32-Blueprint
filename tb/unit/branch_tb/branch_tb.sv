import data_structures::*;

module branch_tb ();

  register_t rs1_i, pc_i, pc_next_o;
  data_t aluout_i, imm_i;
  logic jump_c, branch_c, pcsource_c;

  branch_unit dut (
      .rs1_i(rs1_i),
      .pc_i(pc_i),
      .pc_next_o(pc_next_o),
      .aluout_i(aluout_i),
      .imm_i(imm_i),
      .jump_c(jump_c),
      .branch_c(branch_c),
      .pcsource_c(pcsource_c)
  );

  initial begin
    $display("Inicializando valores...");
    rs1_i = 32'd0;
    pc_i = 32'd0;
    imm_i = 32'd0;
    aluout_i = 32'd0;
    jump_c = 1'b0;
    branch_c = 1'b0;
    pcsource_c = 1'b0;
    #10;

    $display("Testando BRANCH");
    branch_c = 1'b1;
    aluout_i[0] = 1'b1;
    $display("Simulando BRANCH com pc_i = 0x0 e imm_i = 0x0");
    $display("Saída esperada: 0");
    pc_i = 32'd0;
    imm_i = 32'd0;

    #10;
    $display("Zerando valores anteriores...");
    pc_i = 32'd0;
    imm_i = 32'd0;

    $display("Simulando BRANCH com pc_i = 12 e imm_i = 4");
    $display("Saída esperada: 16");
    pc_i = 32'd12;
    imm_i = 32'd4;

    #10;
    $display("Zerando valores anteriores...");
    pc_i = 32'd0;
    imm_i = 32'd0;

    $display("Simulando BRANCH com pc_i = 12 e imm_i = -4");
    $display("Saída esperada: 8");
    pc_i = 32'd12;
    imm_i = -32'd4;

    #10;
    $display("Zerando valores anteriores...");
    pc_i = 32'd0;
    imm_i = 32'd0;
    branch_c = 1'b0;
    aluout_i = 1'b0;

    $display("Testando JAL");
    jump_c = 1'b1;
    $display("Simulando JAL com pc_i = 0x0 e imm_i = 0x0");
    $display("Saída esperada: 0");
    pc_i = 32'd0;
    imm_i = 32'd0;

    #10;
    $display("Zerando valores anteriores...");
    pc_i = 32'd0;
    imm_i = 32'd0;

    $display("Simulando JAL com pc_i = 12 e imm_i = 4");
    $display("Saída esperada: 16");
    pc_i = 32'd12;
    imm_i = 32'd4;

    #10;
    $display("Zerando valores anteriores...");
    pc_i = 32'd0;
    imm_i = 32'd0;

    $display("Simulando JAL com pc_i = 12 e imm_i = -4");
    $display("Saída esperada: 8");
    pc_i = 32'd12;
    imm_i = -32'd4;

    #10;
    $display("Zerando valores anterior rs1es...");
    pc_i = 32'd0;
    imm_i = 32'd0;

    $display("Testando JALR");
    pcsource_c = 1'b1;
    $display("Simulando JALR com rs1_i = 0x0 e imm_i = 0x0");
    $display("Saída esperada: 0");
    rs1_i = 32'd0;
    imm_i = 32'd0;

    #10;
    $display("Zerando valores anteriores...");
    rs1_i = 32'd0;
    imm_i = 32'd0;

    $display("Simulando JALR com rs1_i = 12 e imm_i = 4");
    $display("Saída esperada: 16");
    rs1_i = 32'd12;
    imm_i = 32'd4;

    #10;
    $display("Zerando valores anteriores...");
    rs1_i = 32'd0;
    imm_i = 32'd0;

    $display("Simulando JALR com rs1_i = 12 e imm_i = -4");
    $display("Saída esperada: 8");
    rs1_i = 32'd12;
    imm_i = -32'd4;

    #10;
    $display("Zerando valores anteriores...");
    rs1_i = 32'd0;
    imm_i = 32'd0;
    pcsource_c = 1'b0;

    #10;
    $stop;

  end

endmodule
