module alu (
    input register_t rs1_i,
    input register_t rs2_i,
    input instruction_t instruction_i,

    output data_t alu_out_o
);

  //Decode
  funct3_t funct3;
  funct7_t funct7;
  opcode_t opcode;

  logic [11:0] imm_I;
  logic [31:0] imm_I_ext;

  assign funct7 = instruction_i[31:25];
  assign funct3 = instruction_i[14:12];
  assign opcode = instruction_i[6:0];
  assign imm_I = instruction_i[31:20];

  //Extendendo immediate (repetindo bit de sinal)
  //Todas as extensões de sinal do RISC-V são sign extended
  assign imm_I_ext = {{20{imm_I[11]}}, imm_I};

  always_comb begin
    alu_out_o = 0;
    case (opcode)

      //R-TYPE
      OP: begin
        case ({
          funct3, funct7
        })
          //ADD
          {3'h0, 7'h00} : alu_out_o = rs1_i + rs2_i;
          //SUB
          {3'h0, 7'h20} : alu_out_o = rs1_i - rs2_i;
          //XOR
          {3'h4, 7'h00} : alu_out_o = rs1_i ^ rs2_i;
          //OR
          {3'h6, 7'h00} : alu_out_o = rs1_i | rs2_i;
          //AND
          {3'h7, 7'h00} : alu_out_o = rs1_i & rs2_i;
          //SLL - Todas as operações de shift entre 2 registradores são
          //efetuadas nos 5 bits menos significativos
          {3'h1, 7'h00} : alu_out_o = rs1_i << rs2_i[4:0];
          //SRL
          {3'h5, 7'h00} : alu_out_o = rs1_i >> rs2_i[4:0];
          //SRA
          {3'h5, 7'h20} : alu_out_o = $signed(rs1_i) >>> rs2_i[4:0];
          //SLT
          {3'h2, 7'h00} : alu_out_o = ($signed(rs1_i) < $signed(rs2_i)) ? 1 : 0;
          //SLTU
          {3'h3, 7'h00} : alu_out_o = (rs1_i < rs2_i) ? 1 : 0;
          default: begin
          end

        endcase
      end

      OP_IMM: begin
        casex ({
          funct3, imm_I[11:5]
        })
          //ADDI
          {3'h0, 7'bxxxxxxx} : alu_out_o = rs1_i + imm_I_ext;

          //XORI
          {3'h4, 7'bxxxxxxx} : alu_out_o = rs1_i ^ imm_I_ext;

          //ORI
          {3'h6, 7'bxxxxxxx} : alu_out_o = rs1_i | imm_I_ext;

          //ANDI
          {3'h7, 7'bxxxxxxx} : alu_out_o = rs1_i & imm_I_ext;

          //SLLI
          {3'h1, 7'h00} : alu_out_o = rs1_i << imm_I[4:0];

          //SRLI
          {3'h5, 7'h00} : alu_out_o = rs1_i >> imm_I[4:0];

          //SRAI
          {3'h5, 7'h20} : alu_out_o = $signed(rs1_i) >>> imm_I[4:0];

          //SLTI
          {3'h2, 7'bxxxxxxx} : alu_out_o = ($signed(rs1_i) < $signed(imm_I_ext)) ? 1 : 0;

          //SLTIU
          {3'h3, 7'bxxxxxxx} : alu_out_o = (rs1_i < imm_I_ext) ? 1 : 0;

          default: begin
          end
        endcase
      end

      default: begin

      end
    endcase
  end
endmodule
