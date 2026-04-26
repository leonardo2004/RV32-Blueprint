transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/REGFILE_TB {/home/leotl/Documentos/RV32-Blueprint/REGFILE_TB/data_structures.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/REGFILE_TB {/home/leotl/Documentos/RV32-Blueprint/REGFILE_TB/regfile.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/REGFILE_TB {/home/leotl/Documentos/RV32-Blueprint/REGFILE_TB/tb_regfile.sv}

