# RV32-Blueprint

Processador **RISC-V RV32IM** de ciclo único implementado em SystemVerilog, com E/S mapeada em memória (displays de 7 segmentos e chaves), simulado em ModelSim/Questa e sintetizado para a placa **DE2-115** (Cyclone IV E) com Quartus Prime. Inclui dois programas de demonstração em assembly: fatorial (`fat`) e Fibonacci (`fib`).

## Estrutura do Projeto

```
RV32-Blueprint/
├── README.md
├── .gitignore
├── rtl/
│   ├── README.md
│   ├── core/                 # módulos do processador (inclui integ.sv)
│   └── top/                  # rv32im.sv (top-level da FPGA)
├── tb/
│   ├── README.md
│   └── unit/                 # testbenches (conteúdo integral da antiga TBs/)
├── sw/
│   ├── README.md
│   ├── asm/                  # programas assembly (.S)
│   └── hex/                  # imagens de memória (.hex)
├── quartus/
│   ├── README.md
│   ├── fat/                  # projeto Quartus: fatorial
│   └── fib/                  # projeto Quartus: Fibonacci
└── docs/
    ├── README.md
    ├── relatorios/           # PC1–PC4, Relatorio_Final, Envio.zip
    └── especificacoes/
```

| Pasta | Conteúdo | Documentação |
|-------|----------|--------------|
| [`rtl/`](rtl/) | Módulos do processador RV32IM e top-level | [rtl/README.md](rtl/README.md) |
| [`tb/`](tb/) | Testbenches (ModelSim/Questa) | [tb/README.md](tb/README.md) |
| [`sw/`](sw/) | Programas `fat` e `fib` (fonte e `.hex`) | [sw/README.md](sw/README.md) |
| [`quartus/`](quartus/) | Projetos Quartus e arquivos `.sof` | [quartus/README.md](quartus/README.md) |
| [`docs/`](docs/) | Relatórios PC1–PC4, relatório final e entrega | [docs/README.md](docs/README.md) |
