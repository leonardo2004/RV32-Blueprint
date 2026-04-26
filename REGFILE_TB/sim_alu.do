# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog regfile.sv
vlog tb_regfile.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.tb_regfile

view wave

add wave -divider "Entradas de controle"
add wave -radix binary /tb_regfile/dut/CLK
add wave -radix binary /tb_regfile/dut/RESET
add wave -radix binary /tb_regfile/dut/WE_c


add wave -divider "Entradas de dados"
add wave -radix decimal /tb_regfile/dut/rd_i


add wave -divider "Entradas de endereço"
add wave -radix unsigned /tb_regfile/dut/rs1Addr_i
add wave -radix unsigned /tb_regfile/dut/rs2Addr_i
add wave -radix unsigned /tb_regfile/dut/rdAddr_i


add wave -divider "Saídas de dados"
add wave -radix decimal /tb_regfile/dut/rs2_o
add wave -radix decimal /tb_regfile/dut/rs1_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
