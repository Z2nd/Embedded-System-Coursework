// opcodes.sv
//-----------------------------------------------------
// File Name   : opcodes.sv
// Function    : picoMIPS opcode definitions 
//               for example 28 Feb 14
// only 5 opcodes:   NOP, ADD, ADDI, SUBI, BNE
// Note that Opcodes are 6 bits long and
// the opcodes of ALU instructions have the
// required 3-bit ALU code in the lowest 3 bits
// Author:   tjk
// Last rev. 19 Apr 24
//-----------------------------------------------------

// NOP
`define NOP  6'b000000
// ADD %d, %s;  %d = %d+%s
`define ADD  6'b000010
// ADDI %d, %s, imm ;  %d = %s + imm
`define ADDI  6'b001010
// SUBI %d, %s, imm ;  %d = %s + imm
`define BNE %d, %s, imm; PC = (%d!=%s? PC+ imm : PC+1)
`define BNE  6'b011011

