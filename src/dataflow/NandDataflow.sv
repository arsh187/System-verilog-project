// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// Module   : NandDataflow
// Style    : Dataflow (NAND gates only)
// Description:
//   Implements fire alarm logic using only NAND gates.
//   Y1 = A | B  (Left side extinguisher)
//   Y2 = C | D  (Right side extinguisher)
//   Y3 = Y1 & Y2 (Master alert - 3 or more zones)
// ============================================================

`timescale 1ns / 1ps

module NandDataflow(
    input  logic A, B, C, D,
    output logic Y1, Y2, Y3
);

    // NAND-based NOT: ~X = ~(X & X)
    wire nA = ~(A & A);
    wire nB = ~(B & B);

    // Y1 = A | B = ~(~A & ~B)  using DeMorgan
    assign Y1 = ~(nA & nB);

    wire nC = ~(C & C);
    wire nD = ~(D & D);

    // Y2 = C | D = ~(~C & ~D)  using DeMorgan
    assign Y2 = ~(nC & nD);

    // Y3 = Y1 & Y2 = ~(~Y1 & ~Y2)
    wire nY1 = ~(Y1 & Y1);
    wire nY2 = ~(Y2 & Y2);
    assign Y3 = ~(nY1 & nY2);

endmodule
