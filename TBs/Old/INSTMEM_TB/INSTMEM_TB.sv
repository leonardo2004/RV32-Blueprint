import data_structures::*;

module INSTMEM_TB ();
  wire RESET;
  address_t addr_i;
  instruction_t inst_0;
  integer i;
  logic RESET_input;
  assign RESET = RESET_input;
  inst_memory dut (
    .RESET(RESET),
    .addr_i(addr_i),
    .inst_o(inst_o)
    );

    initial begin
      $display("Começando TB...");

      RESET_input = 0; addr_i = 0;
      #10;

      RESET_input = 1;
      #10;

      for (i = 0;i<16 ; i=i+1) begin
        addr_i = i << 2;
        #10;
      end

      RESET_input = 0;
      #10

      for (i = 16;i<32 ;i=i+1 ) begin
        addr_i = i << 2;
        #10;
      end
    end
endmodule
