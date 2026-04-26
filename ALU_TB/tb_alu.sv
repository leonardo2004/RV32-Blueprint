import data_structures::*;

module tb_alu();

  // Testbench signals
  data_t rs1_i;
  data_t rs2_i;
  data_t imm_i;
  data_t pc_i;
  funct3_t funct3_i;
  funct7_t funct7_i;
  inst_type_t inst_type_c;
  logic alusel1_c;
  logic alusel2_c;
  data_t aluout_o;

  // Instantiate the Device Under Test (DUT)
  alu dut (
    .rs1_i(rs1_i),
    .rs2_i(rs2_i),
    .imm_i(imm_i),
    .pc_i(pc_i),
    .funct3_i(funct3_i),
    .funct7_i(funct7_i),
    .inst_type_c(inst_type_c),
    .alusel1_c(alusel1_c),
    .alusel2_c(alusel2_c),
    .aluout_o(aluout_o)
  );

  // Stimulus block
  initial begin
    $display("Starting ALU Simulation...");
    
    // Default initialization
    rs1_i = 0; rs2_i = 0; imm_i = 0; pc_i = 0;
    funct3_i = 0; funct7_i = 0; 
    inst_type_c = OP;
    alusel1_c = 0; alusel2_c = 0;
    #10; // Wait 10 time units

    // --- 1. Test ADD (R-Type) ---
    // OP, funct3 = 0, funct7 = 0
    rs1_i = 32'd15; rs2_i = 32'd25;
    inst_type_c = OP; funct3_i = 3'd0; funct7_i = 7'd0;
    alusel1_c = 0; alusel2_c = 0; // op1 = rs1, op2 = rs2
    #10;

    // --- 2. Test SUB (R-Type) ---
    // OP, funct3 = 0, funct7 = 32
    rs1_i = 32'd50; rs2_i = 32'd20;
    funct7_i = 7'd32;
    #10;

    // --- 3. Test ADDI (I-Type) ---
    // OPI, funct3 = 0
    rs1_i = 32'd100; imm_i = 32'd75;
    inst_type_c = OPI; funct3_i = 3'd0; funct7_i = 7'b0; // Don't care for funct7 in ADDI usually, but let's set to 0
    alusel1_c = 0; alusel2_c = 1; // op1 = rs1, op2 = imm
    #10;

    // --- 4. Test XOR (R-Type) ---
    // OP, funct3 = 4, funct7 = 0
    rs1_i = 32'hFFFF0000; rs2_i = 32'h0000FFFF;
    inst_type_c = OP; funct3_i = 3'd4; funct7_i = 7'd0;
    alusel1_c = 0; alusel2_c = 0;
    #10;

    // --- 5. Test BRANCH (BEQ) ---
    // BRANCH, funct3 = 0 (EQUAL)
    rs1_i = 32'd50; rs2_i = 32'd50;
    inst_type_c = BRANCH; funct3_i = 3'd0; funct7_i = 7'b0;
    #10;
    // Make them not equal to see the output drop to 0
    rs2_i = 32'd51;
    #10;

    // --- 6. Test JUMP (JAL/JALR) ---
    // Requires PC + 4
    pc_i = 32'h00001004;
    inst_type_c = JUMP;
    alusel1_c = 1; // op1 = pc_i
    #10;

    // --- 7. Test MUL (M Extension) ---
    // OP, funct3 = 0, funct7 = 1
    rs1_i = 32'd7; rs2_i = 32'd6;
    inst_type_c = OP; funct3_i = 3'd0; funct7_i = 7'd1;
    alusel1_c = 0; alusel2_c = 0;
    #10;

    $display("Simulation complete.");
    $stop; // Pauses ModelSim instead of closing it completely
  end

endmodule
