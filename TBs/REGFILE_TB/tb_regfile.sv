import data_structures::*;

module tb_regfile();
logic CLK;
logic RESET;
logic WE_c;
data_t rd_i;
logic [4:0] rdAddr_i, rs1Addr_i, rs2Addr_i;
register_t rs1_o, rs2_o;

regfile dut (
.CLK(CLK),
.RESET(RESET),
.WE_c(WE_c),
.rd_i(rd_i),
.rdAddr_i(rdAddr_i),
.rs1Addr_i(rs1Addr_i),
.rs2Addr_i(rs2Addr_i),
.rs1_o(rs1_o),
.rs2_o(rs2_o)
);

initial begin
$display("LIMPANDO REGISTRADORES PARA COMEÇAR OS TESTES");
RESET=0;
CLK=0;
WE_c=0;
rd_i=0;
rs1Addr_i=0;
rs2Addr_i=0;
rdAddr_i=0;

#10;

$display("x1 = 1 e rs1Addr = 1");
RESET=!RESET;
WE_c=1;
rdAddr_i=1;
rs1Addr_i=1;
rd_i=1;
CLK=!CLK;

#10;

WE_c = 0;


$display("tudo funcionando?");
$stop;
end


endmodule