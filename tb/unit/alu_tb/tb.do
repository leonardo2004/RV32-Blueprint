# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog alu.sv
vlog tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.tb_alu

# Configure the Waveform window
# -- Inputs
add wave -divider "Entrada de instruções"
add wave -color "Orange" -radix unsigned /tb_alu/dut/funct3_i
add wave -color "Orange" -radix unsigned /tb_alu/dut/funct7_i

add wave -divider "Entrada de controle"
add wave -color "Gray60" /tb_alu/dut/alusel1_c
add wave -color "Gray60" /tb_alu/dut/alusel2_c
add wave -color "Gray60" -radix symbolic /tb_alu/dut/inst_type_c

add wave -divider "Entrada de dados"
add wave -color "Cyan" -radix decimal /tb_alu/dut/rs1_i
add wave -color "Cyan" -radix decimal /tb_alu/dut/rs2_i
add wave -color "Cyan" -radix decimal /tb_alu/dut/imm_i
add wave -color "Cyan" -radix hexadecimal /tb_alu/dut/pc_i

add wave -divider "Informações da ULA"
add wave -color "Magenta" -radix symbolic /tb_alu/dut/aluop
add wave -color "Pink" -radix decimal /tb_alu/dut/op_1
add wave -color "Pink" -radix decimal /tb_alu/dut/op_2

add wave -divider "Saída"
add wave -color "Yellow" -radix decimal /tb_alu/dut/aluout_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
