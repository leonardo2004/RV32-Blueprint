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
vlog tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.tb

view wave

add wave -divider "Entradas de controle"
add wave -radix binary /tb/integ/clk_c
add wave -radix binary /tb/integ/RESET

add wave -divider "PC"
add wave -radix hexadecimal /tb/integ/pc

add wave -divider "Saídas de dados"
add wave -radix decimal /tb/integ/rs2
add wave -radix decimal /tb/integ/rs1
add wave -radix decimal /tb/integ/rdaddr
add wave -radix decimal /tb/integ/imm
add wave -radix decimal /tb/integ/aluout
add wave -radix hexadecimal /tb/integ/inst
add wave -radix decimal /tb/integ/rdata

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
