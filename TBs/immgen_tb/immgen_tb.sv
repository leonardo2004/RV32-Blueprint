import data_structures::*;

module immgen_tb ();
  instruction_t inst_i;
  inst_type_t inst_type_c;
  data_t imm_o;

  immediate_generator dut (
      .inst_i(inst_i),
      .inst_type_c(inst_type_c),
      .imm_o(imm_o)
  );

  initial begin
    $display("Inicializando valores...");
    inst_i = 32'd0;
    inst_type_c = OP;

    #10;
    $display("Testando immediato para instruções OPI");
    inst_type_c = OPI;
    $display("Simulando inst_i =32'b11111111111100000000000000000000");
    $display("Saída esperada: -1");
    inst_i = 32'b11111111111100000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    $display("Simulando inst_i =32'b11111111111100000000000000000000");
    $display("Saída esperada: 1");
    inst_i = 32'b00000000000100000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    inst_type_c = OP;

    $display("Testando immediato para instruções LOAD");
    inst_type_c = LOAD;
    $display("Simulando inst_i =32'b11111111111100000000000000000000");
    $display("Saída esperada: -1");
    inst_i = 32'b11111111111100000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    $display("Simulando inst_i =32'b11111111111100000000000000000000");
    $display("Saída esperada: 1");
    inst_i = 32'b00000000000100000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    inst_type_c = OP;

    $display("Testando immediato para instruções AUIPC");
    inst_type_c = AUIPC;
    $display("Simulando inst_i =32'b01000000000000000000000000000000");
    $display("Saída esperada: 1073741824");
    inst_i = 32'b01000000000000000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    $display("Simulando inst_i =32'b11000000000000000000000000000000");
    $display("Saída esperada: -1073741824");
    inst_i = 32'b11000000000000000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    inst_type_c = OP;

    $display("Testando immediato para instruções STORE");
    inst_type_c = STORE;
    $display("Simulando inst_i =32'b01111110000000000000111110000000");
    $display("Saída esperada: 2047");
    inst_i = 32'b01111110000000000000111110000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    $display("Simulando inst_i =32'b110000000000100010010000010100011");
    $display("Saída esperada: -2047");
    inst_i = 32'b10000000000100010010000010100011;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    inst_type_c = OP;


    $display("Testando immediato para instruções BRANCH");
    inst_type_c = BRANCH;
    $display("Simulando inst_i =32'b01000000000000000000000000000000");
    $display("Saída esperada: 1024");
    inst_i = 32'b01000000000000000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    $display("Simulando inst_i =32'b11000000000000000000000010000000");
    $display("Saída esperada: -1024");
    inst_i = 32'b11000000000000000000000010000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    inst_type_c = OP;

    $display("Testando immediato para instruções JUMP");
    inst_type_c = JUMP;
    $display("Simulando inst_i =32'b01000000000000000000000000000000");
    $display("Saída esperada: 1024");
    inst_i = 32'b01000000000000000000000000000000;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    $display("Simulando inst_i =32'b11000000000111111111000001101111");
    $display("Saída esperada: -1024");
    inst_i = 32'b11000000000111111111000001101111;

    #10;
    $display("Zerando os valores...");
    inst_i = 32'd0;
    inst_type_c = OP;
    $stop;
  end
endmodule
