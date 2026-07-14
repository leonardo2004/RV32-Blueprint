import data_structures::*;

module rv32im (
    input logic clk_i,
    input logic RESET,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic [6:0] HEX2,
    output logic [6:0] HEX3,
    input logic [8:0] SW17_9

);

  data_t [1:0] systemoutput;
  data_t [1:0] systeminput;

  int counter = 0;
  logic clk_c = 0;
  always_ff @(posedge clk_i) begin : Divisor
    if (counter == 50) begin
      counter <= 0;
      clk_c   <= ~clk_c;
    end else counter <= counter + 1;
  end

  always_comb begin : Saida
    HEX0 = systemoutput[0][6:0];
    HEX1 = systemoutput[0][14:8];
    HEX2 = systemoutput[0][22:16];
    HEX3 = systemoutput[0][30:24];
  end

  always_comb begin : Entrada
    systeminput[0] = 32'd0;
    systeminput[1] = 32'd0;
    systeminput[1][31:23] = SW17_9;
  end

  integ integ (
      //Entradas
      .clk_i(clk_c),
      .RESET(RESET),
      .systeminput(systeminput),
      .systemoutput(systemoutput)
  );

endmodule
