# rtl

## Descrição
Todo o código RTL sintetizável do processador **RV32IM** de ciclo único, escrito em SystemVerilog. Inclui o pacote de tipos, os blocos do datapath, o módulo de integração (`integ`) e o top-level para a placa DE2-115 (`rv32im`).

## Estrutura
```
rtl/
├── core/   # pacote de tipos, blocos do datapath e módulo de integração
└── top/    # top-level da FPGA (divisor de clock, display e chaves)
```

## Conteúdo

### `core/`
| Arquivo | Módulo | Função |
|---------|--------|--------|
| `data_structures.sv` | pacote `data_structures` | Tipos (`data_t`, `register_t`, `instruction_t`...), enums de opcode (`opcode_t`), tipo de instrução (`inst_type_t`) e operações da ALU (`aluop_t`). Deve ser compilado primeiro. |
| `control_unit.sv` | `control_unit` | Decodifica o opcode e gera os sinais de controle (`memwrite_c`, `memread_c`, `alusel1_c`, `alusel2_c`, `we_c`, `memtoreg_c`, `lui_c`, `branch_c`, `jump_c`, `pcsource_c`, `ebreak_c`) e o `inst_type_c`. |
| `immediate_generator.sv` | `immediate_generator` | Extrai e estende o imediato conforme o tipo da instrução. |
| `regfile.sv` | `regfile` | Banco de registradores (2 leituras, 1 escrita habilitada por `we_c`). |
| `alu.sv` | `alu` | Operações aritméticas, lógicas, shifts, comparações (usadas em branches e SLT) e a extensão **M** (MUL/MULH/MULHSU/MULHU/DIV/DIVU/REM/REMU). |
| `branch_unit.sv` | `branch_unit` | Calcula o próximo PC (`pc + 4`, desvio, JAL ou JALR). |
| `inst_memory.sv` | `inst_memory` | Memória de instruções (ROM) inicializada com `$readmemh("fat.hex", ...)`. |
| `data_memory.sv` | `data_memory` | Memória de dados com acesso por byte/meia-palavra/palavra (LB/LH/LW/LBU/LHU/SB/SH/SW) e E/S mapeada em memória. |
| `integ.sv` | `integ` | Integra todos os blocos acima, o mux de escrita no regfile, o registrador PC e a lógica de *halt* (EBREAK). |

### `top/`
| Arquivo | Módulo | Função |
|---------|--------|--------|
| `rv32im.sv` | `rv32im` | Top-level da FPGA: divide o clock de entrada, liga a saída do processador aos displays `HEX0..HEX3` e as chaves `SW17_9` à entrada. |

### Interface de `integ`
| Porta | Direção | Descrição |
|-------|---------|-----------|
| `clk_i` | entrada | Clock do processador |
| `RESET` | entrada | Reset (nível baixo zera o PC) |
| `systeminput[1:0]` | entrada | Duas palavras de entrada (E/S mapeada em memória) |
| `systemoutput[1:0]` | saída | Duas palavras de saída (E/S mapeada em memória) |

### Como os módulos se conectam
```
              ┌──────────────┐ inst   ┌──────────────┐
   pc ───────►│ inst_memory  ├───────►│ control_unit │──► sinais de controle
   ▲          └──────────────┘   │    └──────────────┘
   │                             ├──► regfile ──► rs1, rs2 ─┐
   │                             └──► immediate_generator ──┤ imm
   │                                                        ▼
 branch_unit ◄── aluout, rs1, imm, pc ◄────────────────── alu
   │                                                        │
   └─ pc_next                           data_memory ◄───────┘ (endereço = aluout, dado = rs2)
                                              │
                      mux (aluout | rdata | imm) ──► regfile (wdata)
```

### Mapa de memória de dados
`data_memory` tem 1024 palavras (4 KiB). As **4 últimas palavras** (`0xFF0`–`0xFFF`) são E/S:

| Endereço | Sentido | Conteúdo |
|----------|---------|----------|
| `0xFF0` | escrita | `systemoutput[1]` |
| `0xFF4` | escrita | `systemoutput[0]` (alimenta `HEX0..HEX3` no top-level) |
| `0xFF8` | leitura | `systeminput[1]` (chaves `SW17_9` em `[31:23]`) |
| `0xFFC` | leitura | `systeminput[0]` |

## Dependências
- `data_structures.sv` é importado por todos os demais módulos (`import data_structures::*;`).
- Ordem de compilação sugerida: `data_structures` → `alu`, `branch_unit`, `control_unit`, `data_memory`, `immediate_generator`, `inst_memory`, `regfile` → `integ` → `rv32im`.

## Observações
- O código é de **RV32IM** (inclui a extensão M), embora o enunciado do projeto cite RV32I.
- `inst_memory` carrega `fat.hex` por padrão (nome fixo no código). Os arquivos `.hex` estão em [`../sw/hex`](../sw/hex); cada pasta de simulação/síntese ([`../tb`](../tb), [`../quartus`](../quartus)) mantém sua própria cópia dos fontes e do `.hex` ao lado, para funcionar de forma independente.
- `rtl/core` e `rtl/top` correspondem à pasta de entrega original (`Envio/`).
