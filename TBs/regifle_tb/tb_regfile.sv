import data_structures::*;

module tb_regfile ();
  logic  clk_c;
  logic  we_c;
  data_t wdata_i;
  logic [4:0] rdaddr_i, rs1addr_i, rs2addr_i;
  register_t rs1_o, rs2_o;

  data_t i;
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


  initial begin
    $display("Inicializando...");
    //Entradas de controle
    we_c = 1;
    clk_c = 0;
    //Entradas de endereço
    rs1addr_i = 0;
    rs2addr_i = 0;
    rdaddr_i = 0;


    for (i = 0; i < 32; i += 1) begin
      wdata_i = i * 4;
      rdaddr_i = i;
      rs1addr_i = i - 1;
      rs2addr_i = i;
      clk_c = 1;
      #10;

      clk_c = 0;
      #10;
    end

    #10;
    $stop;
  end


endmodule

