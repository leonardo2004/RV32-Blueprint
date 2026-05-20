import data_structures::*;

module tb();
  logic clk_c;
  logic memwrite_c;
  logic memread_c;
  funct3_t funct3_i;
  address_t addr_i;
  data_t wdata_i;
  data_t rdata_o;

  data_memory dut (
      .clk_c(clk_c),
      .memwrite_c(memwrite_c),
      .memread_c(memread_c),
      .funct3_i(funct3_i),
      .addr_i(addr_i),
      .wdata_i(wdata_i),
      .rdata_o(rdata_o)
  );

  always #5 clk_c = !clk_c;

  initial begin
    $display("Iniciando TB memória de dados...");
    clk_c = 0;
    memwrite_c = 0;
    memread_c = 0;
    funct3_i = 2;
    addr_i = 0;
    wdata_i = 0;

    #10;
    memwrite_c = 1;
    wdata_i = 2048;

    #10;
    memwrite_c = 0;
    memread_c  = 1;

    #10;
    memwrite_c = 1;
    memread_c = 0;
    funct3_i = 0;
    wdata_i = 10;
    addr_i = 0;

    #10;
    memwrite_c = 0;
    memread_c  = 1;

    #10; addr_i = 0;

    #10;
    funct3_i = 2;
    #10;
    $stop;
  end

endmodule
