import data_structures::*;

module tb ();
  logic RESET;
  address_t addr_i;
  instruction_t inst_0;
  integer i;
  inst_memory dut (
      .RESET (RESET),
      .addr_i(addr_i),
      .inst_o(inst_o)
  );

  initial begin
    $display("Começando TB...");
    RESET  = 1;
    addr_i = 0;

    for (i = 0; i < 10; i++) begin
      addr_i += 4;
      #10;
    end

    $stop;
  end
endmodule
