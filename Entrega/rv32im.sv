import data_structures::*;

module rv32im (
    input logic clk_i,
    RESET,
    input data_t [1:0] systeminput,
    output data_t [1:0] systemoutput
);
  int   counter = 0;
  logic clk_c = 0;
  always_ff @(posedge clk_i) begin : Divisor
	 if (counter == 50) begin
      counter <= 0;
      clk_c   <= ~clk_c;
    end else counter <= counter + 1;
  end


  integ integ (
      //Entradas
      .clk_i(clk_c),
      .RESET(RESET),
      .systeminput(systeminput),
      .systemoutput(systemoutput)
  );

endmodule
