import data_structures::*;

module tb ();

  logic clk_c, RESET;
  data_t [1:0] systeminput;
  data_t [1:0] systemoutput;

  integ integ (
      //Entradas
      .clk_i(clk_c),
      .RESET(RESET),
      .systeminput(systeminput),
      .systemoutput(systemoutput)
  );
  always #10 clk_c = !clk_c;
  int counter = 0;

  initial begin
    RESET = 0;
    clk_c = 0;
    #15;
    RESET = 1;

    systeminput[1] = 32'h05800000;
    systeminput[0] = 128;
    //ADDI x1, x, 1 -> 00000000000100000000000010010011 -> 00100093
    $display("Primeira instrução: ADDI x1, x0, 1");
    #2800;
    #2800;
    $finish;
  end
endmodule
