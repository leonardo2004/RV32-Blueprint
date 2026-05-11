import data_structures::*;

module regfile (
    // Entradas de controle
    input logic we_c,
    clk_c,

    // Entradas
    input data_t wdata_i,
    input logic [4:0] rdaddr_i,
    rs1addr_i,
    rs2addr_i,

    // Saidas
    output register_t rs1_o,
    rs2_o
);

  register_t x[30:0];

  always_ff @(posedge clk_c) begin : reg_write
    if (we_c && rdaddr_i != 0) x[(rdaddr_i-1)] <= wdata_i;
  end

  // reg read
  assign rs1_o = (rs1addr_i == 0) ? 0 : x[rs1addr_i-1];
  assign rs2_o = (rs2addr_i == 0) ? 0 : x[rs2addr_i-1];

endmodule
