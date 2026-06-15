// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : testbench.sv
// Style    : Gate-Level Testbench (Self-Checking)
// Description:
//   Applies all 16 input combinations to FASnor DUT.
//   Builds expected outputs using norgate class instances,
//   mirroring the NOR gate network of the DUT.
//   Reports MATCH/MISMATCH for each combination.
// ============================================================

`timescale 1ns / 1ps

import mygate::*;

module testbench;

    bit a, b, c, d;
    bit y1, y2, y3;
    bit expected_y1, expected_y2, expected_y3;

    // Reference model gate instances
    norgate w1, w2, nor1, nor2, nor3;

    // DUT instance
    FASnor circuit (a, b, c, d, y1, y2, y3);

    // Counters
    int pass_count = 0;
    int fail_count = 0;

    initial begin
        $display("============================================================");
        $display("   Fire Alarm System - Gate-Level (NOR) Testbench");
        $display("============================================================");
        $display(" a  b  c  d | Exp_Y1 Exp_Y2 Exp_Y3 | Act_Y1 Act_Y2 Act_Y3 | Result");
        $display("--------------------------------------------------------------------");

        for (int i = 0; i < 16; i++) begin
            {a, b, c, d} = i;

            // --- Reference model (mirrors NOR gate network) ---

            // w1 = NOR(a, b)
            w1 = new(a, b);
            w1.performlogic();

            // w2 = NOR(c, d)
            w2 = new(c, d);
            w2.performlogic();

            // expected_y1 = NOR(w1, w1) => y1 = a | b
            nor1 = new(w1.o1, w1.o1);
            nor1.performlogic();
            expected_y1 = nor1.o1;

            // expected_y2 = NOR(w2, w2) => y2 = c | d
            nor2 = new(w2.o1, w2.o1);
            nor2.performlogic();
            expected_y2 = nor2.o1;

            // expected_y3 = NOR(w1, w2) => y3 = (a|b) & (c|d)
            nor3 = new(w1.o1, w2.o1);
            nor3.performlogic();
            expected_y3 = nor3.o1;

            #10;  // Wait for DUT to settle

            if (y1 !== expected_y1 || y2 !== expected_y2 || y3 !== expected_y3) begin
                $display(" %b  %b  %b  %b |   %b      %b      %b   |   %b      %b      %b   | MISMATCH ✗",
                    a, b, c, d,
                    expected_y1, expected_y2, expected_y3,
                    y1, y2, y3);
                fail_count++;
            end else begin
                $display(" %b  %b  %b  %b |   %b      %b      %b   |   %b      %b      %b   | MATCH ✓",
                    a, b, c, d,
                    expected_y1, expected_y2, expected_y3,
                    y1, y2, y3);
                pass_count++;
            end
        end

        $display("--------------------------------------------------------------------");
        $display(" Total: %0d PASS | %0d FAIL", pass_count, fail_count);
        $display("============================================================");
        $finish;
    end

endmodule
