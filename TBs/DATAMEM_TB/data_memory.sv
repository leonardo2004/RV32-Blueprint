import data_structures::*;

module data_memory (
    //Entrada de controle
    input wire CLK,
    input wire memwrite_c,
    input wire memread_c,
    input funct3_t funct3_i,

    //Entrada de dados
    input address_t addr_i,
    input data_t wdata_i,

    //Saída de dados
    output data_t rdata_o
);

  data_t data_mem[1023:0];

 

  always @(posedge CLK) begin
    //Escrita
    if (memwrite_c) begin
      case (funct3_i)
        0 : data_mem[addr_i[31:2]] = wdata_i[7:0];
        1 : data_mem[addr_i[31:2]] = wdata_i[15:0];
        default : data_mem[addr_i[31:2]] = wdata_i;
      endcase
    end
    if (memread_c) begin
      case (funct3_i)
        0 : rdata_o = 32'(signed'(data_mem[addr_i[31:2]][7:0]));
        default : rdata_o = data_mem[addr_i[31:2]];
      endcase
    end
  end
endmodule


