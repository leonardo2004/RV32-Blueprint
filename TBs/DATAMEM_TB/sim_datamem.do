# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog data_memory.sv
vlog DATAMEM_TB.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.DATAMEM_TB

# Configure the Waveform window
# -- Inputs
add wave -divider "CONTROLE"
add wave -color "Orange" /DATAMEM_TB/dut/clk_c
add wave -color "Orange" /DATAMEM_TB/dut/memwrite_c
add wave -color "Orange" /DATAMEM_TB/dut/memread_c
add wave -color "Orange" -radix decimal /DATAMEM_TB/dut/funct3_i

add wave -divider "DADOS E ENDEREÇOS"
add wave -color "Cyan" -radix decimal /DATAMEM_TB/dut/wdata_i
add wave -color "Cyan" -radix decimal /DATAMEM_TB/dut/addr_i

add wave -divider "OUTPUT"
add wave -color "Yellow" -radix decimal /DATAMEM_TB/dut/rdata_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
