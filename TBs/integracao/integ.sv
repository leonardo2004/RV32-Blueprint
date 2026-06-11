import data_structures::*;

module integ (
    input logic clk_c,
    RESET
);

  register_t rs1, rs2, pc, pc_next;
  data_t wdata, rdata, imm, aluout;
  logic [4:0] rdaddr, rs1addr, rs2addr;
  funct3_t funct3;
  funct7_t funct7;
  instruction_t inst;

  logic
      memwrite_c,
      memread_c,
      alusel1_c,
      alusel2_c,
      we_c,
      memtoreg_c,
      lui_c,
      branch_c,
      jump_c,
      pcsource_c;

  inst_type_t inst_type_c;



  assign rdaddr  = inst[11:7];
  assign rs2addr = inst[24:20];
  assign rs1addr = inst[19:15];
  assign funct3  = inst[14:12];
  assign funct7  = inst[31:25];


  inst_memory inst_mem (
      .RESET (RESET),
      .addr_i(pc),
      .inst_o(inst)
  );

  regfile regfile (
      .we_c(we_c),
      .clk_c(clk_c),
      .wdata_i(wdata),
      .rdaddr_i(rdaddr),
      .rs1addr_i(rs1addr),
      .rs2addr_i(rs2addr),
      .rs1_o(rs1),
      .rs2_o(rs2)
  );

  alu alu (
      .rs1_i(rs1),
      .rs2_i(rs2),
      .imm_i(imm),
      .pc_i(pc),
      .funct3_i(funct3),
      .funct7_i(funct7),
      .inst_type_c(inst_type_c),
      .alusel1_c(alusel1_c),
      .alusel2_c(alusel2_c),
      .aluout_o(aluout)
  );

  data_memory data_mem (
      .clk_c(clk_c),
      .memwrite_c(memwrite_c),
      .memread_c(memread_c),
      .funct3_i(funct3),
      .addr_i(aluout),
      .wdata_i(rs2),
      .rdata_o(rdata)
  );

  immediate_generator imm_gen (
      .inst_i(inst),
      .inst_type_c(inst_type_c),
      .imm_o(imm)
  );

  // Mux para escrever dados no regfile
  always_comb begin : mux_wdata
    wdata = 0;
    casez ({
      memtoreg_c, lui_c
    })
      2'b00: wdata = aluout;
      2'b10: wdata = rdata;
      2'b?1: wdata = imm;
      default: begin
      end
    endcase

  end

  branch_unit bu (
      .rs1_i(rs1),
      .pc_i(pc),
      .aluout_i(aluout),
      .imm_i(imm),
      .jump_c(jump_c),
      .branch_c(branch_c),
      .pc_next_o(pc_next),
      .pcsource_c(pcsource_c)
  );

  always_ff @(posedge clk_c) begin : pc_update
    pc <= (RESET) ? pc_next : 0;
  end

  control_unit cu (
      .memwrite_c(memwrite_c),
      .memread_c(memread_c),
      .alusel1_c(alusel1_c),
      .alusel2_c(alusel2_c),
      .we_c(we_c),
      .memtoreg_c(memtoreg_c),
      .lui_c(lui_c),
      .branch_c(branch_c),
      .jump_c(jump_c),
      .pcsource_c(pcsource_c),
      .inst_i(inst),
      .inst_type_c(inst_type_c)
  );
endmodule


