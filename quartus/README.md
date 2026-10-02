# quartus

## Descrição
Projetos do Intel Quartus Prime para síntese do processador na placa **DE2-115** (FPGA Cyclone IV E `EP4CE115F29C7`). Os dois projetos são idênticos em hardware e diferem apenas no programa carregado na memória de instruções.

## Estrutura
```
quartus/
├── fat/   # processador executando o programa de fatorial (fat.hex)
└── fib/   # processador executando o programa de Fibonacci (fib.hex)
```
Cada pasta contém: `rv32im.qpf`/`rv32im.qsf` (projeto e atribuições de pinos), os fontes `.sv`, o `.hex`, `link.ld` e `macro.fish`, além de `db/`, `incremental_db/`, `output_files/` (inclui `rv32im.sof`) e `simulation/questa`.

## Conteúdo
- **Entidade top-level**: `rv32im`.
- **Pinos**: `clk_i` no `PIN_Y2` (clock da placa), `RESET` no `PIN_AB28`, `HEX0..HEX3` nos displays de 7 segmentos e `SW17_9` nas chaves.
- **Divisão de clock**: o top-level divide `clk_i` antes de alimentar o processador (ver [`../rtl/top/rv32im.sv`](../rtl/top/rv32im.sv)).

## Como abrir, compilar e programar
1. No Quartus Prime, abra `quartus/fat/rv32im.qpf` (ou `quartus/fib/rv32im.qpf`).
2. *Processing → Start Compilation*.
3. Conecte a DE2-115 por USB-Blaster e abra *Tools → Programmer*.
4. Selecione `output_files/rv32im.sof` e clique em *Start*.
5. Use as chaves `SW17..SW9` para entrada e observe o resultado nos displays `HEX0..HEX3`.

## Dependências
Quartus Prime com suporte à família Cyclone IV E; driver do USB-Blaster.

## Observações
- Cada projeto usa suas **próprias cópias** dos fontes (`.qsf` referencia os arquivos pelo nome, na mesma pasta); por isso as pastas devem permanecer autocontidas.
- Os arquivos de projeto Quartus não foram alterados na reorganização; os diretórios foram apenas movidos.
