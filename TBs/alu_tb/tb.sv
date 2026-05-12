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
    /*
    $display("Instruções tipo R - Deslocamentos");

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
    rs1_i = 32'd100;
    rs2_i = 32'd10;
    funct3_i = 3'd2;
    funct7_i = 7'd0;
    #10;

    //SLTU
    rs1_i = 32'd100;
    rs2_i = 32'd10;
    funct3_i = 3'd3;
    funct7_i = 7'd0;
    #10;

    /*--- 3. Test ADDI (I-Type) ---
    // OPI, funct3 = 0
    rs1_i = 32'd100;
    imm_i = 32'd75;
    inst_type_c = OPI;
    funct3_i = 3'd0;
    alusel1_c = 0;
    alusel2_c = 1;  // op1 = rs1, op2 = imm
    #10;



    // --- 5. Test BRANCH (BEQ) ---
    // BRANCH, funct3 = 0 (EQUAL)
    rs1_i = 32'd50;
    rs2_i = 32'd50;
    inst_type_c = BRANCH;
    funct3_i = 3'd0;
    funct7_i = 7'b0;
    #10;
    // Make them not equal to see the output drop to 0
    rs2_i = 32'd51;
    #10;

    // --- 6. Test JUMP (JAL/JALR) ---
    // Requires PC + 4
    pc_i = 32'h00001004;
    inst_type_c = JUMP;
    alusel1_c = 1;  // op1 = pc_i
    #10;

    // --- 7. Test MUL (M Extension) ---
    // OP, funct3 = 0, funct7 = 1
    rs1_i = 32'd7;
    rs2_i = 32'd6;
    inst_type_c = OP;
    funct3_i = 3'd0;
    funct7_i = 7'd1;
    alusel1_c = 0;
    alusel2_c = 0;
    #10;*/

    $display("Fim");
    $stop;  // Pauses ModelSim instead of closing it completely
  end

endmodule
