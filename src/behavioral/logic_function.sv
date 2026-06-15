// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : logic_function.sv
// Style    : Behavioral (Case Block)
// Description:
//   Implements fire alarm output Y3 (master alert) using
//   a case block covering all 16 input combinations.
//   Y3 is HIGH when (A|B) AND (C|D) — i.e., at least one
//   zone on each side detects fire (3+ zones total).
// ============================================================

`timescale 1ns / 1ps

module logic_function (
    input  wire A,
    input  wire B,
    input  wire C,
    input  wire D,
    output reg  Y1,   // Left extinguisher  (A | B)
    output reg  Y2,   // Right extinguisher (C | D)
    output reg  F     // Master alert       (Y1 & Y2)
);

    reg [3:0] inputs;

    always @(*) begin
        inputs = {A, B, C, D};

        // Y1: left side — fire in zone A or B
        Y1 = A | B;

        // Y2: right side — fire in zone C or D
        Y2 = C | D;

        // F (Y3): master alert — fire on both sides
        case (inputs)
            4'b0000: F = 0;
            4'b0001: F = 0;
            4'b0010: F = 0;
            4'b0011: F = 0;
            4'b0100: F = 0;
            4'b0101: F = 1;
            4'b0110: F = 1;
            4'b0111: F = 1;
            4'b1000: F = 0;
            4'b1001: F = 1;
            4'b1010: F = 1;
            4'b1011: F = 1;
            4'b1100: F = 0;
            4'b1101: F = 1;
            4'b1110: F = 1;
            4'b1111: F = 1;
            default: F = 0;
        endcase
    end

endmodule
