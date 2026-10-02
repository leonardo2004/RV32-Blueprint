import data_structures::*;

module tb_alu ();

  data_t rs1_i;
  data_t rs2_i;
  data_t imm_i;
  data_t pc_i;
  funct3_t funct3_i;
  funct7_t funct7_i;
  inst_type_t inst_type_c;
  logic alusel1_c;
  logic alusel2_c;
  data_t aluout_o;

  alu dut (
      .rs1_i(rs1_i),
      .rs2_i(rs2_i),
      .imm_i(imm_i),
      .pc_i(pc_i),
      .funct3_i(funct3_i),
      .funct7_i(funct7_i),
      .inst_type_c(inst_type_c),
      .alusel1_c(alusel1_c),
      .alusel2_c(alusel2_c),
      .aluout_o(aluout_o)
  );

  initial begin
    $display("Inicializando valores");

    rs1_i = 0;
    rs2_i = 0;
    imm_i = 0;
    pc_i = 0;
    funct3_i = 0;
    funct7_i = 0;
    inst_type_c = OP;
    alusel1_c = 0;
    alusel2_c = 0;
    #10;

    /*
    $display("Instruções tipo R - Aritméticas");
    inst_type_c = OP;
    alusel1_c = 0;
    alusel2_c = 0;

    //ADD
    rs1_i = 32'd15;
    rs2_i = 32'd25;
    funct3_i = 3'd0;
    funct7_i = 7'd0;
    #10;

    //SUB
    rs1_i = 32'd50;
    rs2_i = 32'd20;
    funct3_i = 3'd0;
    funct7_i = 7'd32;
    #10;

    //MUL
    rs1_i = 32'd1000000;
    rs2_i = 32'd1000000;
    funct3_i = 3'd0;
    funct7_i = 7'd1;
    #10;

    //MULH
    rs1_i = 32'd1000000;
    rs2_i = 32'd1000000;
    funct3_i = 3'd1;
    funct7_i = 7'd1;
    #10;

    //MULSU
    rs1_i = -32'd1000000;
    rs2_i = 32'd500000;
    funct3_i = 3'd2;
    funct7_i = 7'd1;
    #10;

    //MULU
    rs1_i = 32'd1000000;
    rs2_i = 32'd500000;
    funct3_i = 3'd3;
    funct7_i = 7'd1;
    #10;

    //DIV
    rs1_i = -32'd50;
    rs2_i = 32'd20;
    funct3_i = 3'd4;
    funct7_i = 7'd1;
    #10;

    //DIVU
    rs1_i = 32'd50;
    rs2_i = 32'd20;
    funct3_i = 3'd5;
    funct7_i = 7'd1;
    #10;

    //REM -Who is Rem?
    rs1_i = -32'd50;
    rs2_i = 32'd20;
    funct3_i = 3'd6;
    funct7_i = 7'd1;
    #10;

    //REMU
    rs1_i = 32'd50;
    rs2_i = 32'd20;
    funct3_i = 3'd7;
    funct7_i = 7'd1;
    #10;
    */

    /*
    $display("Instruções tipo R - Shift");

    //SLL
    rs1_i = 32'h0000FFFF;
    rs2_i = 32'h4;
    funct3_i = 3'd1;
    funct7_i = 7'd0;
    #10;

    //SRL
    rs1_i = 32'hFFFF0000;
    rs2_i = 32'h4;
    funct3_i = 3'd5;
    funct7_i = 7'd0;
    #10;

    //SRA
    rs1_i = 32'hFFFF0000;
    rs2_i = 32'h4;
    funct3_i = 3'd5;
    funct7_i = 7'd32;
    #10;
    */

    /*
    $display("Instruções do tipo R - Lógicas");
    //XOR
    rs1_i = 32'hFFFF0000;
    rs2_i = 32'h0000FFFF;
    funct3_i = 3'd4;
    funct7_i = 7'd0;
    #10;

    //OR
    rs1_i = 32'hFFFF0000;
    rs2_i = 32'hFF00FF00;
    funct3_i = 3'd6;
    funct7_i = 7'd0;
    #10;

    //AND
    rs1_i = 32'hFFFF0000;
    rs2_i = 32'hFF00FF00;
    funct3_i = 3'd7;
    funct7_i = 7'd0;
    #10;


    //SLT
    rs1_i = 32'd10;
    rs2_i = 32'd100;
    funct3_i = 3'd2;
    funct7_i = 7'd0;
    #10;

    //SLTU
    rs1_i = 32'd10;
    rs2_i = 32'd100;
    funct3_i = 3'd3;
    funct7_i = 7'd0;
    #10;
*/

    /*
    $display("Instruções tipo I");
    inst_type_c = OPI;
    alusel1_c = 0;
    alusel2_c = 1;  // op1 = rs1, op2 = imm

    // ADDI
    rs1_i = 32'd100;
    imm_i = 32'd75;
    funct3_i = 3'd0;
    #10;

    // XORI
    rs1_i = 32'd1;
    imm_i = 32'd3;
    funct3_i = 3'd4;
    #10;

    // ORI
    rs1_i = 32'd1;
    imm_i = 32'd2;
    funct3_i = 3'd6;
    #10;

    // ANDI
    rs1_i = 32'd1;
    imm_i = 32'd3;
    funct3_i = 3'd7;
    #10;

    // SLL
    rs1_i = 32'd1024;
    imm_i = 32'd1;
    funct3_i = 3'd1;
    funct7_i = 7'd0;
    #10;

    // SRL
    rs1_i = 32'd1024;
    imm_i = 32'd1;
    funct3_i = 3'd5;
    funct7_i = 7'd0;
    #10;

    // SRA
    rs1_i = -32'd1024;
    imm_i = 32'd1;
    funct3_i = 3'd5;
    funct7_i = 7'd32;
    #10;

    // SLT
    rs1_i = 32'd1024;
    imm_i = -32'd1;
    funct3_i = 3'd2;
    funct7_i = 7'd32;
    #10;

    // SLTU
    rs1_i = 32'd1024;
    imm_i = -32'd1;
    funct3_i = 3'd3;
    funct7_i = 7'd32;
    #10;

    */

    /*
    $display("Instruções LOAD e Instruções STORE");
    alusel1_c = 0;
    alusel2_c = 1;

    //LOAD
    inst_type_c = LOAD;
    rs1_i = 32'h00000000;
    imm_i = 32'h0000000F;
    #10;

    //STORE
    inst_type_c = STORE;
    #10;
*/

/*
    $display("Instruções tipo B");
    inst_type_c = BRANCH;
    alusel1_c = 0;
    alusel2_c = 0;

    //BEQ
    rs1_i = 32'd50;
    rs2_i = 32'd50;
    funct3_i = 3'd0;
    #10;

    rs2_i = 32'd51;
    #10;

    //BNE
    rs1_i = 32'd50;
    rs2_i = 32'd50;
    funct3_i = 3'd1;
    #10;

    rs2_i = 32'd51;
    #10;

    //BLT
    rs1_i = 32'd50;
    rs2_i = -32'd50;
    funct3_i = 3'd4;
    #10;

    rs2_i = 32'd51;
    #10;

    //BGE
    rs1_i = 32'd50;
    rs2_i = -32'd50;
    funct3_i = 3'd5;
    #10;

    rs2_i = 32'd50;
    #10;
    rs2_i = 32'd51;
    #10;
    //BLTU
    rs1_i = 32'd50;
    rs2_i = 32'd50;
    funct3_i = 3'd6;
    #10;

    rs2_i = 32'd51;
    #10;

    //BGEU
    rs1_i = 32'd50;
    rs2_i = 32'd50;
    funct3_i = 3'd7;
    #10;

    rs2_i = 32'd51;
    #10;
    rs2_i = -32'd51;
    #10;

    */
    $display("Instruções tipo J");
    //JAL E JALR
    pc_i = 32'h00001004;
    inst_type_c = JUMP;
    alusel1_c = 1;  // op1 = pc_i
    #10;

    //AUIPC
    imm_i = 4;
    alusel2_c = 1;
    inst_type_c = AUIPC;
    #10;

    $display("Fim");
    $stop;  // Pauses ModelSim instead of closing it completely
  end

endmodule
