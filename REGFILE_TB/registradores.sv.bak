import data_structures::*;

module registradores (
    input wire CLK,
    RESET,

    input wire WE_c,

    input data_t rd_i,
    input wire [4:0] rdAddr_i,
    rs1Addr_i,
    rs2Addr_i,

    output register_t rs1_o,
    rs2_o
);

  register_t [30:0] x;
  const register_t zero = 0;

  always @(posedge CLK) begin
    if (!RESET) begin
      for (int i = 0; i < 31; i++) x[i] <= 0;
    end else if (WE_c && rdAddr_i != 0) begin
      x[(rdAddr_i-1)] <= rd_i;
    end

  end

  assign rs1_o = (rs1Addr_i == 0) ? 0 : x[rs1Addr_i-1];
  assign rs2_o = (rs2Addr_i == 0) ? 0 : x[rs2Addr_i-1];

endmodule
