transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/CU_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/CU_TB/data_structures.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/CU_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/CU_TB/control_unit.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/CU_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/CU_TB/cu_tb.sv}

