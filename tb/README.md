# tb

## Descrição
> ⚠️ **Revisar:** as descrições deste README foram **inferidas do código** (nomes de módulos, `.do` e mensagens dos testbenches), não de documentação do autor. Confira antes de tomar como definitivas.

Testbenches em SystemVerilog para simulação em **ModelSim / Questa**. Cada pasta é autocontida: traz cópias dos fontes necessários, o script `.do` de simulação e capturas das formas de onda.

## Estrutura
```
tb/
└── unit/              # conteúdo integral da antiga pasta TBs/
    ├── alu_tb/
    ├── branch_tb/
    ├── control_tb/
    ├── datamemory_tb/
    ├── immgen_tb/
    ├── instmemory_tb/
    ├── reg&ula_tb/    # regfile + ALU em conjunto
    ├── regifle_tb/
    └── integracao/    # processador completo executando fat/fib
```

## Conteúdo
| Pasta | Script | Testbench | O que valida |
|-------|--------|-----------|--------------|
| `unit/alu_tb` | `tb.do` | `tb.sv` (`tb_alu`) | Operações da ALU: tipo R (aritméticas, lógicas, shifts), tipo I, LOAD/STORE, branches e jumps |
| `unit/branch_tb` | `sim_branch.do` | `branch_tb.sv` | Cálculo do próximo PC em BRANCH, JAL e JALR |
| `unit/control_tb` | `sim_cu.do` | `cu_tb.sv` | Sinais de controle por opcode |
| `unit/datamemory_tb` | `sim.do` | `tb.sv` | Leituras/escritas por byte, meia-palavra e palavra |
| `unit/immgen_tb` | `sim_immgen.do` | `immgen_tb.sv` | Geração de imediatos por tipo de instrução |
| `unit/instmemory_tb` | `sim_instmem.do` | `tb.sv` | Leitura da memória de instruções (`dados.txt`) |
| `unit/reg&ula_tb` | `sim.do` | `tb.sv` | Integração banco de registradores + ALU |
| `unit/regifle_tb` | `sim_regfile.do` | `tb_regfile.sv` | Banco de registradores |
| `unit/integracao` | `sim.do` | `tb.sv` | Processador completo (`integ`) rodando os programas `fat` e `fib` |

Arquivos `.bmp` e `.pdf` nas pastas são capturas de formas de onda usadas nos relatórios.

## Como executar
Ferramentas: ModelSim ou Questa (Intel FPGA Edition). Entre **na pasta do testbench** (os `vlog` e o `$readmemh` usam caminhos relativos) e execute o script:

```bash
cd tb/unit/alu_tb
vsim -do tb.do          # abre a GUI e roda; ou, dentro do vsim: do tb.do
```

Para o teste de integração:
```bash
cd tb/unit/integracao
vsim -do sim.do
```

## Dependências
- O pacote `data_structures.sv` precisa ser compilado antes dos demais (os `.do` já fazem isso).
- A integração lê o programa via `inst_memory.sv` (`$readmemh`), usando o `.hex` presente na própria pasta.

## Observações
- `work/`, `vsim.wlf` e `vsim_stacktrace.vstf` são artefatos gerados pelo simulador.
- Os testbenches terminam com `$stop`, mantendo o simulador aberto para inspeção das ondas.
