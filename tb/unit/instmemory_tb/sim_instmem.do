# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog inst_memory.sv
vlog tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.tb

view wave

add wave -divider "Entradas de endereço"
add wave -color "Orange" -radix hexadecimal /tb/dut/addr_i

add wave -divider "Saídas"
add wave -color "Yellow" -radix hexadecimal /tb/dut/inst_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
