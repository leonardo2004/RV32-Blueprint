import data_structures::*;

module data_memory (
    //Entrada de controle
    input logic clk_c,
    memwrite_c,
    memread_c,
    input funct3_t funct3_i,

    //Entrada de dados
    input address_t addr_i,
    input data_t wdata_i,

    //Saída de dados
    output data_t rdata_o
);

  data_t data_mem[1024];

  // Lógica do byte enabler ; Essencial para LH, LB, LHU, LBU
  logic [3:0] be;
  always_comb begin : be_generator
    if (funct3_i == 3'b000 || funct3_i == 3'b100) begin
      case (addr_i[1:0])
        2'b00: be = 4'b0001;
        2'b01: be = 4'b0010;
        2'b10: be = 4'b0100;
        2'b11: be = 4'b1000;
        default: begin
        end
      endcase
    end else if (funct3_i == 3'b001 || funct3_i == 3'b101) begin
      case (addr_i[1])
        1'b0: be = 4'b0011;
        1'b1: be = 4'b1100;
        default: begin
        end
      endcase
    end else if (funct3_i == 3'b010) be = 4'b1111;
    else be = 4'b0000;

  end

  always_ff @(posedge clk_c) begin

    if (memwrite_c) begin : mem_write
      case (be)
        4'b0001: data_mem[addr_i[31:2]][7:0] <= wdata_i[7:0];
        4'b0010: data_mem[addr_i[31:2]][15:8] <= wdata_i[7:0];
        4'b0100: data_mem[addr_i[31:2]][23:16] <= wdata_i[7:0];
        4'b1000: data_mem[addr_i[31:2]][31:24] <= wdata_i[7:0];
        4'b0011: data_mem[addr_i[31:2]][15:0] <= wdata_i[15:0];
        4'b1100: data_mem[addr_i[31:2]][31:16] <= wdata_i[15:0];
        4'b1111: data_mem[addr_i[31:2]][31:0] <= wdata_i[31:0];
        default: begin
        end
      endcase
    end

    if (memread_c) begin : mem_read
      if (funct3_i == 3'b000 || funct3_i == 3'b001 || funct3_i == 3'b010) begin : signed_read
        case (be)
          4'b0001: rdata_o <= 32'(signed'(data_mem[addr_i[31:2]][7:0]));
          4'b0010: rdata_o <= 32'(signed'(data_mem[addr_i[31:2]][15:8]));
          4'b0100: rdata_o <= 32'(signed'(data_mem[addr_i[31:2]][23:16]));
          4'b1000: rdata_o <= 32'(signed'(data_mem[addr_i[31:2]][31:24]));
          4'b0011: rdata_o <= 32'(signed'(data_mem[addr_i[31:2]][15:0]));
          4'b1100: rdata_o <= 32'(signed'(data_mem[addr_i[31:2]][31:16]));
          4'b1111: rdata_o <= data_mem[addr_i[31:2]][31:0];
          default: begin
          end
        endcase
      end
      if (funct3_i == 3'b100 || funct3_i == 3'b101) begin : unsigned_read
        case (be)
          4'b0001: rdata_o <= 32'(unsigned'(data_mem[addr_i[31:2]][7:0]));
          4'b0010: rdata_o <= 32'(unsigned'(data_mem[addr_i[31:2]][15:8]));
          4'b0100: rdata_o <= 32'(unsigned'(data_mem[addr_i[31:2]][23:16]));
          4'b1000: rdata_o <= 32'(unsigned'(data_mem[addr_i[31:2]][31:24]));
          4'b0011: rdata_o <= 32'(unsigned'(data_mem[addr_i[31:2]][15:0]));
          4'b1100: rdata_o <= 32'(unsigned'(data_mem[addr_i[31:2]][31:16]));
          default: begin
          end
        endcase
      end
    end
  end
endmodule


