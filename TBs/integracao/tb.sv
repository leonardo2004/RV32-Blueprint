import data_structures::*;

module tb ();

  logic
      clk_c,
      RESET;

  integ integ (
      //Entradas
      .clk_c(clk_c),
      .RESET(RESET)
  );

  always #10 clk_c = !clk_c;

  initial begin
    RESET = 0;clk_c = 0;
    #15;
    RESET = 1;
    //ADDI x1, x, 1 -> 00000000000100000000000010010011 -> 00100093
    $display("Primeira instrução: ADDI x1, x0, 1");
    #1400;
    $finish;
  end
endmodule
