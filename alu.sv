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

  assign funct7 = instruction_i[31:25];
  assign funct3 = insctrution_i[14:12];
  assign opcode = instruction_i[6:0];
  assign imm_I  = instruction_i[31:20];


  always_comb begin
    case (opcode)

      //R-TYPE
      OP: begin
        case ({funct3, funct7})
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
          //SLL
          {3'h1, 7'h00} : alu_out_o = rs1_i << rs2_i;
          //SRL
          {3'h5, 7'h00} : alu_out_o = rs1_i >> rs2_i;
          //SRA
          {3'h5, 7'h20} : alu_out_o = $signed(rs1_i) >>> rs2_i;
          //SLT
          {3'h2, 7'h00} : alu_out_o = ($signed(rs1_i) < $signed(rs2_i)) ? 1 : 0;
          //SLTU
          {3'h3, 7'h00} : alu_out_o = (rs1_i < rs2_i) ? 1 : 0;
          default: begin
          end

        endcase
      end

      OP_IMM: begin

      end

      default: begin

      end
    endcase
  end
endmodule
