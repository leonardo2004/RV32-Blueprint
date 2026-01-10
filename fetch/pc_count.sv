import data_structures::register_t;

module pc_count (
    input wire CLK,
    input wire RESET,

    output register_t PC_o,
    output register_t PCp4_o  //PC + 4
);

initial begin
    PC_o = 0;
end

  always @(posedge CLK) begin
    PC_o <= (!RESET) ? 0 : PCp4_o;
  end

  assign PCp4_o = PC_o + 4;

endmodule

