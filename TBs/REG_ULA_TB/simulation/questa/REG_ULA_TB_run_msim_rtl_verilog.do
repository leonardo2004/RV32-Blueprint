transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/data_structures.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/integ.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/inst_memory.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/data_memory.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/regfile.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/alu.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/REG_ULA_TB/REG_ULA_TB.sv}

