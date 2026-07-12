import data_structures::*;

module inst_memory (
    input address_t addr_i,
    output instruction_t inst_o
);

  data_t rom[256];

  //Inicialização de memória de instruções,
  //modificar para inserir programas


  initial begin
    $readmemh("fat.hex", rom);
  end

  assign inst_o = rom[addr_i[8:2]];
endmodule
