# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog branch_unit.sv
vlog branch_tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.branch_tb

view wave

add wave -divider "Entradas de controle"
add wave -color "Gray60" -radix binary /branch_tb/dut/jump_c
add wave -color "Gray60" -radix binary /branch_tb/dut/branch_c
add wave -color "Gray60" -radix binary /branch_tb/dut/pcsource_c


add wave -divider "Entradas de dados"
add wave -color "Cyan" -radix decimal /branch_tb/dut/rs1_i
add wave -color "Cyan" -radix decimal /branch_tb/dut/pc_i
add wave -color "Cyan" -radix decimal /branch_tb/dut/aluout_i
add wave -color "Cyan" -radix decimal /branch_tb/dut/imm_i


add wave -divider "Saídas de dados"
add wave -color "Yellow" -radix decimal /branch_tb/dut/pc_next_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
