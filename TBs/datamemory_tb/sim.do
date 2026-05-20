# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog data_memory.sv
vlog tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.tb

# Configure the Waveform window
# -- Inputs
add wave -divider "Entradas de Controle"
add wave -color "Orange" /tb/dut/clk_c
add wave -color "Orange" /tb/dut/memwrite_c
add wave -color "Orange" /tb/dut/memread_c
add wave -color "Orange" -radix decimal /tb/dut/funct3_i

add wave -divider "Entradas de dados"
add wave -color "Cyan" -radix decimal /tb/dut/wdata_i
add wave -divider "Entradas de endereços"
add wave -color "Cyan" -radix decimal /tb/dut/addr_i

add wave -divider "Saídas"
add wave -color "Yellow" -radix decimal /tb/dut/rdata_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
