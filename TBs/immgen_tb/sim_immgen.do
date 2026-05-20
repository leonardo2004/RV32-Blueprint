# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog immediate_generator.sv
vlog immgen_tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.immgen_tb

view wave

add wave -divider "Entradas de controle"
add wave -color "Gray60" -radix symbolic /immgen_tb/dut/inst_type_c


add wave -divider "Entradas de instruções"
add wave -color "Orange" -radix hexadecimal /immgen_tb/dut/inst_i


add wave -divider "Saídas de dados"
add wave -color "Yellow" -radix decimal /immgen_tb/dut/imm_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
