import data_structures::*;

module tb_regfile ();
  logic  clk_c;
  logic  we_c;
  data_t wdata_i;
  logic [4:0] rdaddr_i, rs1addr_i, rs2addr_i;
  register_t rs1_o, rs2_o;

  integer i;
  regfile dut (
      .clk_c(clk_c),
      .we_c(we_c),
      .wdata_i(wdata_i),
      .rdaddr_i(rdaddr_i),
      .rs1addr_i(rs1addr_i),
      .rs2addr_i(rs2addr_i),
      .rs1_o(rs1_o),
      .rs2_o(rs2_o)
  );

  always #5 clk_c = !clk_c;

  initial begin
    $display("Inicializando...");
    //Entradas de controle
    we_c = 1;
    clk_c = 0;
    //Entradas de endereço
    rs1addr_i = 0;
    rs2addr_i = 0;
    rdaddr_i = 0;

    //Entrada de dados

    wdata_i = 0;
    #10;
    //Inicializando todos os registradores em zero para mais facil compreensao
    for (i = 1; i < 32; i = i + 1) begin
      rdaddr_i = i;
      wdata_i  = 0;
      #10;
    end

    #10;

    $display("x1 = 2004 e rs1addr = 1");
    // Controle
    we_c = 1;

    // Registradores de saída
    rs1addr_i = 1;
    rs2addr_i = 0;

    // Registradores de entrada
    rdaddr_i = 1;

    // Valores de entrada
    wdata_i = 2004;

    #10;

    $display("x1 = 2004 e rs2addr = 2");
    // Controle
    we_c = 0;

    // Registradores de saída
    rs1addr_i = 1;
    rs2addr_i = 2;

    // Registradores de entrada
    rdaddr_i = 1;

    // Valores de entrada
    wdata_i = 2004;

    #10;

    $display("x2 = 2000");
    // Controle
    we_c = 1;

    // Registradores de saída
    rs1addr_i = 2;
    rs2addr_i = 0;

    // Registradores de entrada
    rdaddr_i = 2;

    // Valores de entrada
    wdata_i = 2000;

    #10;
    $stop;
  end


endmodule

