# Create the working library
vlib work

# Compile the files in the correct order (Packages first)
vlog data_structures.sv
vlog regfile.sv
vlog alu.sv
vlog tb.sv

# Start the simulation, disabling optimization (+acc) so we can see all signals
vsim -voptargs="+acc" work.tb

view wave

add wave -divider "Entradas de controle"
add wave -color "Gray60" -radix binary /tb/regfile/clk_c
add wave -color "Gray60" -radix binary /tb/regfile/we_c
add wave -color "Gray60" -radix binary /tb/alu/alusel1_c
add wave -color "Gray60" -radix binary /tb/alu/alusel2_c
add wave -color "Gray60" -radix symbolic /tb/alu/inst_type_c

add wave -divider "Entradas de instrução"
add wave -color "Orange" -radix hexadecimal /tb/alu/funct3_i
add wave -color "Orange" -radix hexadecimal /tb/alu/funct7_i

add wave -divider "Entradas de dados"
add wave -color "Cyan" -radix decimal /tb/regfile/wdata_i
add wave -color "Cyan" -radix decimal /tb/alu/pc_i
add wave -color "Cyan" -radix decimal /tb/alu/imm_i

add wave -divider "Entradas de endereço"
add wave -color "Orange" -radix unsigned /tb/regfile/rs1addr_i
add wave -color "Orange" -radix unsigned /tb/regfile/rs2addr_i
add wave -color "Orange" -radix unsigned /tb/regfile/rdaddr_i


add wave -divider "Saídas"
add wave -color "Yellow" -radix decimal /tb/regfile/rs2_o
add wave -color "Yellow" -radix decimal /tb/regfile/rs1_o
add wave -color "Yellow" -radix decimal /tb/alu/aluout_o

# Run the simulation until $stop is reached
run -all

# Zoom out to fit all waves on screen
wave zoom full
