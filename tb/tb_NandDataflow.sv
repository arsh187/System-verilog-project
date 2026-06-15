// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : tb_NandDataflow.sv
// Style    : Dataflow Testbench (Self-Checking)
// Description:
//   Applies all 16 input combinations to NandDataflow DUT.
//   Compares actual outputs with reference class model.
//   Reports PASS/FAIL for each combination.
// ============================================================

`timescale 1ns / 1ps

module tb_NandDataflow;

    import andlogic_pkg::*;

    // DUT signals
    logic A, B, C, D;
    logic Y1, Y2, Y3;

    // Instantiate DUT
    NandDataflow dut (
        .A(A), .B(B), .C(C), .D(D),
        .Y1(Y1), .Y2(Y2), .Y3(Y3)
    );

    // Reference model instances
    Y1Logic y1_ref = new();
    Y2Logic y2_ref = new();
    Y3Logic y3_ref = new();

    // Expected outputs
    logic expY1, expY2, expY3;

    // Pass/fail counter
    int pass_count = 0;
    int fail_count = 0;

    initial begin
        $display("============================================================");
        $display("   Fire Alarm System - Dataflow (NAND) Testbench");
        $display("============================================================");
        $display(" A  B  C  D | Y1  Y2  Y3 | Exp_Y1 Exp_Y2 Exp_Y3 | Result");
        $display("------------------------------------------------------------");

        for (int i = 0; i < 16; i++) begin
            {A, B, C, D} = i[3:0];
            #10;  // Wait for DUT to settle

            // Compute expected outputs using reference model
            expY1 = y1_ref.compute(A, B, C, D);
            expY2 = y2_ref.compute(A, B, C, D);
            expY3 = y3_ref.compute(A, B, C, D);

            // Display and compare
            if ((Y1 !== expY1) || (Y2 !== expY2) || (Y3 !== expY3)) begin
                $display(" %b  %b  %b  %b |  %b   %b   %b  |   %b      %b      %b   | FAIL ✗",
                    A, B, C, D, Y1, Y2, Y3, expY1, expY2, expY3);
                fail_count++;
            end else begin
                $display(" %b  %b  %b  %b |  %b   %b   %b  |   %b      %b      %b   | PASS ✓",
                    A, B, C, D, Y1, Y2, Y3, expY1, expY2, expY3);
                pass_count++;
            end
        end

        $display("------------------------------------------------------------");
        $display(" Total: %0d PASS | %0d FAIL", pass_count, fail_count);
        $display("============================================================");
        $finish;
    end

endmodule
