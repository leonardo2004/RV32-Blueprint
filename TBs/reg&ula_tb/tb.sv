import data_structures::*;

module tb ();
  //Entradas
  //  Instrução
  funct3_t funct3_i;
  funct7_t funct7_i;

  //  Controle
  logic clk_c, we_c, alusel1_c, alusel2_c;
  inst_type_t inst_type_c;

  //  Dados
  data_t imm_i;
  register_t pc_i;

  //  Endereços
  logic [4:0] rdaddr_i, rs1addr_i, rs2addr_i;

  //Varíaveis
  register_t rs1, rs2, aluout;
  data_t i, wdata;

  //Componentes
  regfile regfile (
      .clk_c(clk_c),
      .we_c(we_c),
      .wdata_i(wdata),
      .rdaddr_i(rdaddr_i),
      .rs1addr_i(rs1addr_i),
      .rs2addr_i(rs2addr_i),
      .rs1_o(rs1),
      .rs2_o(rs2)
  );

  alu alu (
      .rs1_i(rs1),
      .rs2_i(rs2),
      .imm_i(imm_i),
      .pc_i(pc_i),
      .funct3_i(funct3_i),
      .funct7_i(funct7_i),
      .inst_type_c(inst_type_c),
      .alusel1_c(alusel1_c),
      .alusel2_c(alusel2_c),
      .aluout_o(aluout)
  );

  //Clock
  always #5 clk_c = !clk_c;

  //Para fins de teste wdata_i = aluout_o
  assign wdata = aluout;

  initial begin
    $display("Inicializando...");
    //Entradas de controle
    we_c = 0;
    clk_c = 0;
    alusel1_c = 0;
    alusel2_c = 0;
    inst_type_c = OP;

    //Entradas de instrução
    funct3_i = 3'b000;
    funct7_i = 7'b0000000;

    //Entradas de dados
    imm_i = 0;
    pc_i = 0;

    //Entradas de endereço
    rs1addr_i = 0;
    rs2addr_i = 0;
    rdaddr_i = 0;

    #10;

    //Instrução ADDI x1, x0, 99
    inst_type_c = OPI;
    alusel2_c = 1;
    we_c = 1;

    rdaddr_i = 1;
    rs1addr_i = 0;

    imm_i = 32'd99;

    #10;

    //Instrução ADDI x2, x1, 7
    rdaddr_i = 2;
    rs1addr_i = 1;

    imm_i = 32'd9;

    #10;

    //Instrução ADDI x1, x0, 3
    rs1addr_i = 0;
    rdaddr_i = 1;

    imm_i = 32'd3;

    #10;

    //Instrução DIV x3, x2, x1
    alusel2_c = 0;
    inst_type_c = OP;
    funct3_i = 7'd4;
    funct7_i = 7'd1;

    rdaddr_i = 3;
    rs1addr_i = 2;
    rs2addr_i = 1;

    #10;
    $stop;
  end


endmodule

