
lui x31, 1 //Carrega 4096
addi x28, x0, 192
slli x28, x28, 8
addi x28, x28, 192
slli x28, x28, 8
addi x28, x28, 192
slli x28, x28, 8
addi x28, x28, 192
sw x28, -12(x31)


//x31 endereço
//x5 confirma
//x30 valor de fib
start_loop:
lui x31, 1 //Carrega 4096
lbu x5, -6(x31) // Le o se o valor já foi escolhido
lbu x30, -5(x31) // Le o valor escolhido de fib
andi x5, x5, 128 //Vê se o bit mais significativo é 1
bne x5, x0, fib_start
j start_loop

//X5 e x6 valores iniciais
//x7 contador
fib_start:
addi x5, x0, 0
addi x6, x0, 1
addi x7, x0, 1
beq x30, x0, fib_0

//x8 temporario
fib_loop:
bge x7, x30, fib_end
addi x7, x7, 1
add x8, x6, x0
add x6, x6, x5
add x5, x8, x0
jal x0, fib_loop

//x29 valor calculado
fib_end:
add x29, x6, x0

//x29 = valor de entrada
//x5 = 10
//x2 = x29
display:
addi x5, x0, 10
add x2, x29, x0

// x3 = valor do primeiro display
display_0:
rem x3, x2, x5
div x2, x2, x5
call table
add x27, x28, x0

display_1:
rem x3, x2, x5
div x2, x2, x5
call table
slli x28, x28, 8
or x27, x27, x28

display_2:
rem x3, x2, x5
div x2, x2, x5
call table
slli x28, x28, 16
or x27, x27, x28

display_3:
rem x3, x2, x5
div x2, x2, x5
call table
slli x28, x28, 24
or x27, x27, x28

sw x27, -12(x31)

ebreak

table:
//x4 = temporario subtrator
//x28 = valor onde vai ser escrito
addi x4, x3, 0
beq x4, x0, case_0

addi x4, x3, -1
beq x4, x0, case_1

addi x4, x3, -2
beq x4, x0, case_2

addi x4, x3, -3
beq x4, x0, case_3

addi x4, x3, -4
beq x4, x0, case_4

addi x4, x3, -5
beq x4, x0, case_5

addi x4, x3, -6
beq x4, x0, case_6 

addi x4, x3, -7 
beq x4, x0, case_7

addi x4, x3, -8
beq x4, x0, case_8 

addi x4, x3, -9
beq x4, x0, case_9
ret

case_0:
addi x28, x0, 192
ret

case_1:
addi x28, x0, 249
ret

case_2:
addi x28, x0, 164
ret

case_3:
addi x28, x0, 176
ret

case_4:
addi x28, x0, 153
ret

case_5:
addi x28, x0, 146
ret

case_6:
addi x28, x0, 130
ret

case_7:
addi x28, x0, 248
ret

case_8:
addi x28, x0, 128
ret

case_9:
addi x28, x0, 144
ret

fib_0: 
addi x29, x0, 0
j display
