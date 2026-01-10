import data_structures::*;

module fetch (
    input wire CLK,
    RESET,
    output instruction_t inst_o
);

  register_t PC_address, PC_p4;
  pc_count pc_count (
      .CLK(CLK),
      .RESET(RESET),
      .PC_o(PC_address),
      .PCp4_o(PC_p4)
  );

  inst_memory inst_memory (
      .RESET (RESET),
      .addr_i(PC_address),
      .inst_o(inst_o)
  );
endmodule

