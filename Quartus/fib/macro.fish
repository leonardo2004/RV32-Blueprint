read -l -P "Qual o arquivo de origem?" origem
read -l -P "Qual o arquivo de destino?" destino

riscv64-elf-gcc -march=rv32im -mabi=ilp32 -nostartfiles -T link.ld $origem -o output.elf
riscv64-elf-objcopy -j .text -O binary output.elf inst.bin
python3 -c "import sys; data=open('inst.bin','rb').read(); [print(f'{int.from_bytes(data[i:i+4], \"little\"):08x}') for i in range(0, len(data), 4)]" >$destino
rm output.elf
rm inst.bin
