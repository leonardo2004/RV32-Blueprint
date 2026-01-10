import data_structures::*;

module inst_memory (
    input wire RESET,
    input register_t addr_i,
    output instruction_t inst_o
);

  initial begin
    integer i;
    for (i = 0; i < 1024; i = i + 1) begin
      ins_mem[i] = i * 2;
    end
  end

  instruction_t ins_mem[1023:0];
  assign inst_o = (!RESET) ? 0 : ins_mem[addr_i[31:2]];

endmodule
