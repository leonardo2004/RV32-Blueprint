# sw

## Descrição
> ⚠️ **Revisar:** a descrição dos programas e do fluxo de geração foi **inferida do código** (`.S`, `macro.fish`, `inst_memory.sv`). Confira antes de tomar como definitiva.

Programas em assembly RISC-V (RV32IM) usados para validar o processador e os arquivos `.hex` correspondentes, carregados na memória de instruções.

## Estrutura
```
sw/
├── asm/   # código-fonte assembly
└── hex/   # memórias de instruções geradas (uma palavra de 32 bits em hexadecimal por linha)
```

## Conteúdo
| Arquivo | Descrição |
|---------|-----------|
| `asm/fatasmhalt.S` | Programa de **fatorial**: espera o valor ser escolhido nas chaves, calcula e mostra o resultado nos displays; termina com `ebreak` (halt). |
| `asm/fibasmhalt.S` | Programa de **Fibonacci**: mesmo esquema de E/S, termina com `ebreak`. |
| `hex/fat.hex` | Imagem de memória do programa de fatorial. |
| `hex/fib.hex` | Imagem de memória do programa de Fibonacci. |

Ambos usam E/S mapeada em memória (ver mapa em [`../rtl/README.md`](../rtl/README.md)): lêem as chaves em `0xFFA`/`0xFFB` (`x31 = 0x1000`, offsets `-6`/`-5`) e escrevem nos displays em `0xFF4`.

## Como gerar o `.hex`
O script `macro.fish` (um em cada pasta de [`../quartus/fat`](../quartus/fat), [`../quartus/fib`](../quartus/fib) e [`../tb/unit/integracao`](../tb/unit/integracao), junto de `link.ld`) automatiza a compilação. Requer `riscv64-elf-gcc`, `riscv64-elf-objcopy`, `python3` e o shell `fish`:

```fish
cd quartus/fat
fish macro.fish
# Qual o arquivo de origem? fatasmhalt.S
# Qual o arquivo de destino? fat.hex
```
Etapas executadas pelo script:
1. `riscv64-elf-gcc -march=rv32im -mabi=ilp32 -nostartfiles -T link.ld <origem> -o output.elf`
2. `riscv64-elf-objcopy -j .text -O binary output.elf inst.bin`
3. Conversão de `inst.bin` em palavras little-endian de 32 bits em hexadecimal (uma por linha) no arquivo de destino.

## Como carregar no processador
`rtl/core/inst_memory.sv` lê o programa com `$readmemh("fat.hex", rom)`. Basta que o `.hex` esteja no diretório de trabalho da simulação ou do projeto Quartus (as cópias já estão em `tb/unit/integracao` e `quartus/fat|fib`).

## Dependências
Toolchain RISC-V (`riscv64-elf-*`), `python3` e `fish` apenas para regenerar os `.hex`.

## Observações
- O nome do arquivo está fixo em `inst_memory.sv`; para trocar de programa, o `.hex` desejado deve ter esse nome na pasta em uso.
