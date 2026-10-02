import data_structures::*;

module tb ();
  address_t addr_i;
  instruction_t inst_0;
  integer i;
  inst_memory dut (
      .addr_i(addr_i),
      .inst_o(inst_o)
  );

  initial begin
    $display("Começando TB...");
    addr_i = 0;

    for (i = 0; i < 10; i++) begin
      addr_i += 4;
      #10;
    end

    $stop;
  end
endmodule
