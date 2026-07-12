import data_structures::*;

module regfile (
    // Entradas de controle
    input logic we_c,
    input logic clk_i,
    input logic RESET,

    // Entradas
    input data_t wdata_i,
    input logic [4:0] rdaddr_i,
    input logic [4:0] rs1addr_i,
    input logic [4:0] rs2addr_i,

    // Saidas
    output register_t rs1_o,
    output register_t rs2_o
);

  register_t x[31];

  always_ff @(posedge clk_i) begin : reg_write
    if (we_c && rdaddr_i != 0) x[(rdaddr_i-1)] <= wdata_i;

    if (!RESET) begin
      for (int i = 0; i < 31; i++) begin
        x[i] <= 32'b0;
      end
    end
  end

  // reg read
  assign rs1_o = (rs1addr_i == 0) ? 0 : x[rs1addr_i-1];
  assign rs2_o = (rs2addr_i == 0) ? 0 : x[rs2addr_i-1];

endmodule
