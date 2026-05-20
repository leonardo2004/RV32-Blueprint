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
add wave -color "Gray60" -radix binary /tb_regfile/dut/we_c
add wave -color "Gray60" -radix binary /tb_regfile/dut/clk_c


add wave -divider "Entradas de dados"
add wave -color "Cyan" -radix decimal /tb_regfile/dut/wdata_i


add wave -divider "Entradas de endereço"
add wave -color "Orange" -radix unsigned /tb_regfile/dut/rs1addr_i
add wave -color "Orange" -radix unsigned /tb_regfile/dut/rs2addr_i
add wave -color "Orange" -radix unsigned /tb_regfile/dut/rdaddr_i


add wave -divider "Saídas"
add wave -color "Yellow" -radix decimal /tb_regfile/dut/rs2_o
add wave -color "Yellow" -radix decimal /tb_regfile/dut/rs1_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
