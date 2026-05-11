transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/IMMGEN_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/IMMGEN_TB/data_structures.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/IMMGEN_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/IMMGEN_TB/immediate_generator.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/IMMGEN_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/IMMGEN_TB/immgen_tb.sv}

