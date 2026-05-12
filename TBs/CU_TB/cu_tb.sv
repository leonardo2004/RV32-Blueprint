import data_structures::*;

module cu_tb ();
  instruction_t inst_i;
  inst_type_t   inst_type_c;

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

  control_unit dut (
      .inst_i(inst_i),
      .inst_type_c(inst_type_c),
      .memwrite_c(memwrite_c),
      .memread_c(memread_c),
      .alusel1_c(alusel1_c),
      .alusel2_c(alusel2_c),
      .we_c(we_c),
      .memtoreg_c(memtoreg_c),
      .lui_c(lui_c),
      .branch_c(branch_c),
      .jump_c(jump_c),
      .pcsource_c(pcsource_c)
  );

  initial begin


    // 1. Teste: Tipo-R (OP)
    inst_i = 32'h00000033;
    #10;


    // 2. Teste: Tipo-I (OP_IMM)
    inst_i = 32'h00000013;
    #10;


    // 3. Teste: LOAD
    inst_i = 32'h00000003;
    #10;


    // 4. Teste: STORE
    inst_i = 32'h00000023;
    #10;

    // 5. Teste: BRANCH
    inst_i = 32'h00000063;
    #10;

    // 6. Teste: JAL
    inst_i = 32'h0000006F;
    #10;

    // 7. Teste: JALR
    inst_i = 32'h00000067;
    #10;

    // 8. Teste: LUI
    inst_i = 32'h00000037;
    #10;

    // 9. Teste: AUIPC
    inst_i = 32'h00000017;

    #20;
    $stop;
  end


endmodule
