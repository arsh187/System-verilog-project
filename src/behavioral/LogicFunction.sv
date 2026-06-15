// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : LogicFunction.sv  (logic_pkg package)
// Style    : Behavioral - OOP Reference Model Package
// Description:
//   Class-based reference model for the behavioral style.
//   Used in testbench to generate expected output F (Y3).
// ============================================================

package logic_pkg;

    class LogicFunction;

        // Member variables
        bit A, B, C, D;
        bit Y1, Y2, F;

        // Constructor
        function new(input bit a, input bit b,
                     input bit c, input bit d);
            A = a;
            B = b;
            C = c;
            D = d;
        endfunction

        // Compute all outputs using case statement
        function void compute();
            bit [3:0] inputs;
            inputs = {A, B, C, D};

            Y1 = A | B;
            Y2 = C | D;

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
        endfunction

    endclass

endpackage
