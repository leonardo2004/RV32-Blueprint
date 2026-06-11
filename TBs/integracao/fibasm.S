addi x5, x0, 0
addi x6, x0, 1
addi x10, x0, 7
addi x28, x0, 1

loop:
bge x28, x10, end
addi x28, x28, 1
addi x29, x6, 0
add x6, x6, x5
addi x5, x29, 0
jal x0, loop

end:
addi x6, x6, 0
sw x6, 0(x0)
lw x30, 0(x0)

