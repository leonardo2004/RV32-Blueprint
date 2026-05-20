# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog alu.sv
vlog branch_unit.sv
vlog control_unit.sv
vlog data_memory.sv
vlog immediate_generator.sv
vlog inst_memory.sv
vlog regfile.sv
vlog integ.sv
vlog REG_ULA_TB.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.REG_ULA_TB

view wave

add wave -divider "Entradas de controle"
add wave -radix binary /REG_ULA_TB/integ/clk_c
add wave -radix binary /REG_ULA_TB/integ/RESET

add wave -divider "PC"
add wave -radix hexadecimal /REG_ULA_TB/integ/pc

add wave -divider "Saídas de dados"
add wave -radix decimal /REG_ULA_TB/integ/rs1_o
add wave -radix decimal /REG_ULA_TB/integ/rs2_o
add wave -radix decimal /REG_ULA_TB/integ/imm
add wave -radix decimal /REG_ULA_TB/integ/aluout_o
add wave -radix hexadecimal /REG_ULA_TB/integ/inst_o
add wave -radix decimal /REG_ULA_TB/integ/rdata_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
