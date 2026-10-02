
# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog control_unit.sv
vlog cu_tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.cu_tb

view wave

add wave -divider "Entradas de instruções"
add wave -color "Magenta" -radix decimal /cu_tb/dut/inst_i


add wave -divider "Tipo de instrução"
add wave -color "Orange" -radix symbolic /cu_tb/dut/inst_type_c

add wave -divider "Tipo de instrução"
add wave -color "Gray60" -radix binary /cu_tb/dut/memwrite_c
add wave -color "Gray60" -radix binary /cu_tb/dut/memread_c
add wave -color "Gray60" -radix binary /cu_tb/dut/alusel1_c
add wave -color "Gray60" -radix binary /cu_tb/dut/alusel2_c
add wave -color "Gray60" -radix binary /cu_tb/dut/we_c
add wave -color "Gray60" -radix binary /cu_tb/dut/memtoreg_c
add wave -color "Gray60" -radix binary /cu_tb/dut/lui_c
add wave -color "Gray60" -radix binary /cu_tb/dut/branch_c
add wave -color "Gray60" -radix binary /cu_tb/dut/jump_c
add wave -color "Gray60" -radix binary /cu_tb/dut/pcsource_c
add wave -color "Gray60" -radix binary /cu_tb/dut/ebreak_c

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
