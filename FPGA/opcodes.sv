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
// Arithmetic Register-Register
// ADD %d, %s;  %d = %d+%s (uses default ALUfunc)
`define ADD  6'b000010
// SUB %d, %s;  %d = %d-%s (uses default ALUfunc)
`define SUB  6'b000011 // New: Ends in 011 (RSUB)

// Arithmetic Register-Immediate
// ADDI %d, %s, imm ;  %d = %s + imm
`define ADDI  6'b001010 // New: Ends in 010 (RADD)
// SUBI %d, %s, imm ;  %d = %s - imm
`define SUBI  6'b001011 // New: Ends in 011 (RSUB)

// Branches
// BNE %d, %s, imm; PC = (%d!=%s? PC+ imm : PC+1) // Check Z flag
`define BNE  6'b011011
// BEQ %d, %s, imm; PC = (%d==%s? PC+ imm : PC+1) // Check Z flag
`define BEQ  6'b010011 // New: Example opcode
// BGE %d, %s, imm; PC = (%d>=%s? PC+ imm : PC+1) // Check N flag (signed) or Z/N (unsigned)
`define BGE  6'b010111 // New: Example opcode (Condition depends on interpretation)
// BLO %d, %s, imm; PC = (%d<%s? PC+ imm : PC+1) // Check C flag (unsigned)
`define BLO  6'b011111 // New: Example opcode

