// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : logic_function_tb.sv
// Style    : Behavioral Testbench (Task-Based)
// Description:
//   Uses a reusable task to apply all 16 input combinations.
//   Compares DUT output with reference class model.
//   Displays PASS/FAIL for each test case.
// ============================================================

`timescale 1ns / 1ps

module logic_function_tb;

    import logic_pkg::*;

    // DUT signals
    reg  a, b, c, d;
    wire y1, y2, f;

    // Expected outputs
    bit expected_y1, expected_y2, expected_f;

    // DUT instance
    logic_function dut (
        .A(a), .B(b), .C(c), .D(d),
        .Y1(y1), .Y2(y2), .F(f)
    );

    // Reference class handle
    LogicFunction lf;

    // Counters
    int pass_count = 0;
    int fail_count = 0;

    // --------------------------------------------------------
    // Task: Apply inputs, compute expected, compare & display
    // --------------------------------------------------------
    task run_test(input bit a_in, b_in, c_in, d_in);
        begin
            a = a_in;
            b = b_in;
            c = c_in;
            d = d_in;

            // Compute expected outputs using reference model
            lf = new(a, b, c, d);
            lf.compute();
            expected_y1 = lf.Y1;
            expected_y2 = lf.Y2;
            expected_f  = lf.F;

            #5;  // Wait for DUT to evaluate

            if ((y1 !== expected_y1) || (y2 !== expected_y2) || (f !== expected_f)) begin
                $display(" FAIL ✗ | A=%0b B=%0b C=%0b D=%0b => DUT(Y1=%0b Y2=%0b F=%0b) Exp(Y1=%0b Y2=%0b F=%0b)",
                    a, b, c, d, y1, y2, f, expected_y1, expected_y2, expected_f);
                fail_count++;
            end else begin
                $display(" PASS ✓ | A=%0b B=%0b C=%0b D=%0b => Y1=%0b  Y2=%0b  F=%0b",
                    a, b, c, d, y1, y2, f);
                pass_count++;
            end
        end
    endtask

    // --------------------------------------------------------
    // Run all 16 input combinations
    // --------------------------------------------------------
    initial begin
        $display("============================================================");
        $display("   Fire Alarm System - Behavioral Testbench");
        $display("============================================================");

        run_test(0, 0, 0, 0);
        run_test(0, 0, 0, 1);
        run_test(0, 0, 1, 0);
        run_test(0, 0, 1, 1);
        run_test(0, 1, 0, 0);
        run_test(0, 1, 0, 1);
        run_test(0, 1, 1, 0);
        run_test(0, 1, 1, 1);
        run_test(1, 0, 0, 0);
        run_test(1, 0, 0, 1);
        run_test(1, 0, 1, 0);
        run_test(1, 0, 1, 1);
        run_test(1, 1, 0, 0);
        run_test(1, 1, 0, 1);
        run_test(1, 1, 1, 0);
        run_test(1, 1, 1, 1);

        $display("------------------------------------------------------------");
        $display(" Total: %0d PASS | %0d FAIL", pass_count, fail_count);
        $display("============================================================");
        $finish;
    end

endmodule
