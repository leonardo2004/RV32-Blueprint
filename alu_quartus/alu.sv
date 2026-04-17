import data_structures::*;

module alu (
    input data_t rs1_i,
    input data_t rs2_i,
    input data_t imm_i,
    input data_t pc_i,

    input funct3_t funct3_i,
    input funct7_t funct7_i,

    input inst_type_t inst_type_c,

    input logic alusel1_c,
    input logic alusel2_c,

    output data_t aluout_o
);
  

  aluop_t aluop;
  data_t op_1;
  data_t op_2;
  logic [63:0] tmp_reg;

  always_comb begin : ALUcontrol

    casez ({
      inst_type_c, funct3_i, funct7_i
    })
      //OP
      {OP, 3'd0, 7'd0} :  aluop = ADD;
      {OP, 3'd0, 7'd32} : aluop = SUB;
      {OP, 3'd4, 7'd0} :  aluop = XOR;
      {OP, 3'd6, 7'd0} :  aluop = OR;
      {OP, 3'd7, 7'd0} :  aluop = AND;
      {OP, 3'd1, 7'd0} :  aluop = SLL;
      {OP, 3'd5, 7'd0} :  aluop = SRL;
      {OP, 3'd5, 7'd32} : aluop = SRA;
      {OP, 3'd2, 7'd0} :  aluop = SLT;
      {OP, 3'd3, 7'd0} :  aluop = SLTU;
      //EXTENSÃO M
      {OP, 3'd0, 7'd1} :  aluop = MUL;
      {OP, 3'd1, 7'd1} :  aluop = MULH;
      {OP, 3'd2, 7'd1} :  aluop = MULSU;
      {OP, 3'd3, 7'd1} :  aluop = MULU;
      {OP, 3'd4, 7'd1} :  aluop = DIV;
      {OP, 3'd5, 7'd1} :  aluop = DIVU;
      {OP, 3'd6, 7'd1} :  aluop = REM;
      {OP, 3'd7, 7'd1} :  aluop = REMU;

      //OPI
      {OPI, 3'd0, 7'd?} :  aluop = ADD;
      {OPI, 3'd4, 7'd?} :  aluop = XOR;
      {OPI, 3'd6, 7'd?} :  aluop = OR;
      {OPI, 3'd7, 7'd?} :  aluop = AND;
      {OPI, 3'd1, 7'd0} :  aluop = SLL;
      {OPI, 3'd5, 7'd0} :  aluop = SRL;
      {OPI, 3'd5, 7'd32} : aluop = SRA;
      {OPI, 3'd2, 7'd?} :  aluop = SLT;
      {OPI, 3'd3, 7'd?} :  aluop = SLTU;

      //LOAD
      {LOAD, 3'd?, 7'd?} : aluop = ADD;

      //STORE
      {STORE, 3'd?, 7'd?} : aluop = ADD;

      //BRANCH
      {BRANCH, 3'd0, 7'd?} : aluop = EQUAL;
      {BRANCH, 3'd1, 7'd?} : aluop = NEQUAL;
      {BRANCH, 3'd4, 7'd?} : aluop = SLT;
      {BRANCH, 3'd5, 7'd?} : aluop = GOET;
      {BRANCH, 3'd6, 7'd?} : aluop = SLTU;
      {BRANCH, 3'd7, 7'd?} : aluop = GETU;

      //JAL e JALR
      {JUMP, 3'd?, 7'd?} : aluop = PCP4;

      //AUIPC
      {AUIPC, 3'd?, 7'd?} : aluop = ADD;

      default: aluop = ADD;
    endcase
  end

  always_comb begin : Op_Generator
  op_1 = 0;
  op_2 = 0;
    if (!alusel1_c) begin
      op_1 = rs1_i;
    end else begin
      op_1 = pc_i;
    end

    if (!alusel2_c) begin
      op_2 = rs2_i;
    end else begin
      op_2 = imm_i;
    end
  end




  always_comb begin
    aluout_o = 0;
    tmp_reg = 0;
    case (aluop)
      ADD:    aluout_o = op_1 + op_2;
      SUB:    aluout_o = op_1 - op_2;
      XOR:    aluout_o = op_1 ^ op_2;
      OR:     aluout_o = op_1 | op_2;
      AND:    aluout_o = op_1 & op_2;
      SLL:    aluout_o = op_1 << op_2[4:0];
      SRL:    aluout_o = op_1 >> op_2[4:0];
      SRA:    aluout_o = $signed(op_1) >>> op_2[4:0];
      SLT:    aluout_o = ($signed(op_1) < $signed(op_2)) ? 1 : 0;
      SLTU:   aluout_o = (op_1 < op_2) ? 1 : 0;
      EQUAL:  aluout_o = $signed(op_1) == $signed(op_2);
      NEQUAL: aluout_o = $signed(op_1) != $signed(op_2);
      GOET:   aluout_o = ($signed(op_1) >= $signed(op_2)) ? 1 : 0;
      GETU:   aluout_o = (op_1 >= op_2) ? 1 : 0;
      PCP4:   aluout_o = op_1 + 4;
      MUL: begin
        tmp_reg  = ($signed(op_1) * $signed(op_2));
        aluout_o = tmp_reg[31:0];
      end
      MULH: begin
        tmp_reg  = ($signed(op_1) * $signed(op_2));
        aluout_o = tmp_reg[63:32];
      end
      MULSU: begin
        tmp_reg  = ($signed(op_1) * op_2);
        aluout_o = tmp_reg[63:32];
      end
      MULU: begin
        tmp_reg  = (op_1 * op_2);
        aluout_o = tmp_reg[63:32];
      end
      DIV:    aluout_o = (op_2 == 0) ? {32{1'b1}} : $signed(op_1) / $signed(op_2);
      DIVU:   aluout_o = (op_2 == 0) ? {32{1'b1}} : op_1 / op_2;
      REM:    aluout_o = $signed(op_1) % $signed(op_2);
      REMU:   aluout_o = op_1 % op_2;

      default: begin
		end
    endcase
  end

endmodule
