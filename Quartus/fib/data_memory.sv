
import data_structures::*;


module data_memory (
    //Entrada de controle
    input logic clk_i,
    input logic memwrite_c,
    input logic memread_c,

    input funct3_t funct3_i,

    //Entrada de dados
    input address_t addr_i,
    input data_t wdata_i,
    input data_t [1:0] systeminput_i,

    //Saída de dados
    output data_t rdata_o,
    output data_t [1:0] systemoutput_o
);

  //Declaração de memória
  localparam int MEMORY_SIZE = 1024;
  (* ramstyle = "M9K" *) data_t data_mem[MEMORY_SIZE];
  data_t io_mem[4];

  //Declaração de variáveis pra salvar minha vida
  address_t word_addr;
  address_t io_addr;

  data_t mem_data;
  data_t io_data;
  data_t raw_data;

  logic is_io;

  //Assignments pra deixar minha vida mais fácil
  assign word_addr = addr_i >> 2;
  assign io_addr = word_addr - (MEMORY_SIZE - 4);
  assign is_io = (word_addr >= (MEMORY_SIZE - 4));
  assign raw_data = (is_io) ? io_data : mem_data;


  // Lógica do byte enabler ; Essencial para LH, LB, LHU, LBU
  logic [3:0] be;
  always_comb begin : be_generator
    be = 4'b0000;
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


  always_ff @(negedge clk_i) begin : Write
    //IO
    io_mem[3] <= systeminput_i[0];
    io_mem[2] <= systeminput_i[1];
    systemoutput_o[0] <= io_mem[1];
    systemoutput_o[1] <= io_mem[0];

    if (memwrite_c) begin
      //Se é memória
      if (word_addr < MEMORY_SIZE - 4) begin : Mem
        for (int i = 0; i < 4; i++) if (be[i]) data_mem[word_addr][i*8+:8] <= wdata_i[i*8+:8];
      end  //Se é IO
      else begin : IO
        for (int i = 0; i < 4; i++) if (be[i]) io_mem[io_addr][i*8+:8] <= wdata_i[i*8+:8];
      end
    end

    mem_data <= (word_addr < MEMORY_SIZE - 4) ? data_mem[word_addr] : 0;
    io_data  <= (io_addr < 4) ? io_mem[io_addr] : 0;

  end
  always_comb begin : Read
    rdata_o = 0;
    if (memread_c) begin
      if (funct3_i == 3'b000 || funct3_i == 3'b001 || funct3_i == 3'b010) begin : Signed
        case (be)
          4'b0001: rdata_o = 32'(signed'(raw_data[7:0]));
          4'b0010: rdata_o = 32'(signed'(raw_data[15:8]));
          4'b0100: rdata_o = 32'(signed'(raw_data[23:16]));
          4'b1000: rdata_o = 32'(signed'(raw_data[31:24]));
          4'b0011: rdata_o = 32'(signed'(raw_data[15:0]));
          4'b1100: rdata_o = 32'(signed'(raw_data[31:16]));
          4'b1111: rdata_o = raw_data;
          default: begin
          end
        endcase
      end
      if (funct3_i == 3'b100 || funct3_i == 3'b101) begin : Unsigned
        case (be)
          4'b0001: rdata_o = 32'(unsigned'(raw_data[7:0]));
          4'b0010: rdata_o = 32'(unsigned'(raw_data[15:8]));
          4'b0100: rdata_o = 32'(unsigned'(raw_data[23:16]));
          4'b1000: rdata_o = 32'(unsigned'(raw_data[31:24]));
          4'b0011: rdata_o = 32'(unsigned'(raw_data[15:0]));
          4'b1100: rdata_o = 32'(unsigned'(raw_data[31:16]));
          default: begin
          end
        endcase
      end
    end
  end
endmodule


