import data_structures::*;

module data_memory (
    input wire CLK,
    input address_t addr_i,
    input register_t writeData_i,
    input wire memWrite_i,
    input wire memRead_i,

    output register_t readData_o
);

  data_t data_mem[1023:0];

  assign readData_o = (memRead_i) ? data_mem[addr_i[31:2]] : 0;

  always @(posedge CLK) begin : blockName
    if (memWrite_i) begin
      data_mem[addr_i[31:2]] = writeData_i;
    end
  end
endmodule

 
