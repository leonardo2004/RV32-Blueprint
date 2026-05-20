# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog inst_memory.sv
vlog INSTMEM_TB.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.INSTMEM_TB

view wave

add wave -divider "Entradas de controle"
add wave -radix binary /INSTMEM_TB/dut/RESET


add wave -divider "Entradas de dados"


add wave -divider "Entradas de endereço"
add wave -radix unsigned /INSTMEM_TB/dut/addr_i


add wave -divider "Saídas de dados"
add wave -radix decimal /INSTMEM_TB/dut/inst_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
