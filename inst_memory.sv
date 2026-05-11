import data_structures::*;

module inst_memory (
    input wire RESET,
    input address_t addr_i,
    output instruction_t inst_o
);

  instruction_t ins_mem [1023:0];

  //Inicialização de memória de instruções,
  //modificar para inserir programas

  initial begin
    /*integer i;
    for (i = 0; i < 1024; i = i + 1) begin
      ins_mem[i] = i * 2;
    end*/
    $readmemb("dados.txt", ins_mem);
  end

  assign inst_o = (!RESET) ? 0 : ins_mem[addr_i[31:2]];

endmodule
