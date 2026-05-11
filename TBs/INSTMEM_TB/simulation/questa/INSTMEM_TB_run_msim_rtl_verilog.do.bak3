transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/INSTMEM_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/INSTMEM_TB/data_structures.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/INSTMEM_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/INSTMEM_TB/inst_memory.sv}
vlog -sv -work work +incdir+/home/leotl/Documentos/RV32-Blueprint/TBs/INSTMEM_TB {/home/leotl/Documentos/RV32-Blueprint/TBs/INSTMEM_TB/INSTMEM_TB.sv}

