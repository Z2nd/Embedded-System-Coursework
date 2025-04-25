//---------------------------------------------------------
// File Name   : decodertest.sv
// Function    : Basic testbench for picoMIPS instruction decoder
// Author: tjk (modified)
// Last revised: 25 Apr 25
//---------------------------------------------------------

`timescale 1ns / 1ps // Define timescale for simulation delays

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decodertest;

  // Inputs to the decoder DUT
  logic [5:0] opcode_in;
  logic [3:0] flags_in; // V, N, Z, C

  // Outputs from the decoder DUT
  logic       PCincr_out;
  logic       PCabsbranch_out;
  logic       PCrelbranch_out;
  logic [2:0] ALUfunc_out;
  logic       imm_out;
  logic       w_out;

  // Instantiate the Device Under Test (DUT)
  decoder dut (
      .opcode(opcode_in),
      .flags(flags_in),
      .PCincr(PCincr_out),
      .PCabsbranch(PCabsbranch_out),
      .PCrelbranch(PCrelbranch_out),
      .ALUfunc(ALUfunc_out),
      .imm(imm_out),
      .w(w_out)
  );

  // Stimulus and Checking Block
  initial begin
    $display("Starting Decoder Testbench...");
    $monitor("Time=%0t Opcode=%b Flags=%b -> PCincr=%b PCabs=%b PCrel=%b ALUfunc=%b imm=%b w=%b",
             $time, opcode_in, flags_in, PCincr_out, PCabsbranch_out, PCrelbranch_out, ALUfunc_out, imm_out, w_out);

    // Initialize inputs
    opcode_in = `NOP;
    flags_in = 4'b0000; // V=0, N=0, Z=0, C=0
    #10; // Wait 10 time units

    // Test NOP
    $display("Testing NOP...");
    opcode_in = `NOP;
    #10; // Expected: PCincr=1, others=0 (except ALUfunc maybe 000)

    // Test ADD
    $display("Testing ADD...");
    opcode_in = `ADD;
    #10; // Expected: PCincr=1, w=1, ALUfunc=RADD (010), others=0

    // Test SUBI
    $display("Testing SUBI...");
    opcode_in = `SUBI;
    #10; // Expected: PCincr=1, w=1, imm=1, ALUfunc=RSUB (011), others=0

    // Test BNE (condition false: Z=1)
    $display("Testing BNE (Z=1, Branch Not Taken)...");
    opcode_in = `BNE;
    flags_in = 4'b0010; // V=0, N=0, Z=1, C=0
    #10; // Expected: PCincr=1, PCrel=0 (branch not taken)

    // Test BNE (condition true: Z=0)
    $display("Testing BNE (Z=0, Branch Taken)...");
    opcode_in = `BNE;
    flags_in = 4'b0000; // V=0, N=0, Z=0, C=0
    #10; // Expected: PCincr=0, PCrel=1 (branch taken)

    // Test BEQ (condition true: Z=1)
    $display("Testing BEQ (Z=1, Branch Taken)...");
    opcode_in = `BEQ;
    flags_in = 4'b0010; // V=0, N=0, Z=1, C=0
    #10; // Expected: PCincr=0, PCrel=1 (branch taken)

    // Test BGE (condition true: N=0)
    $display("Testing BGE (N=0, Branch Taken)...");
    opcode_in = `BGE;
    flags_in = 4'b0010; // Z=1 -> N=0
    #10; // Expected: PCincr=0, PCrel=1 (branch taken)

     // Test BLO (condition true: C=1)
    $display("Testing BLO (C=1, Branch Taken)...");
    opcode_in = `BLO;
    flags_in = 4'b0001; // V=0, N=0, Z=0, C=1
    #10; // Expected: PCincr=0, PCrel=1 (branch taken)

    // Test an unimplemented opcode (optional)
    // $display("Testing Unimplemented Opcode...");
    // opcode_in = 6'b111111; // Example invalid opcode
    // #10; // Expected: $error message during simulation if default case works

    $display("Decoder Testbench Finished.");
    $finish; // End the simulation
  end

endmodule //module decodertest