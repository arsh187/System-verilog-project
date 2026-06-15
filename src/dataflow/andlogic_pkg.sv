// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : andlogic_pkg.sv
// Style    : Dataflow - OOP Reference Model Package
// Description:
//   Contains class-based reference models for Y1, Y2, Y3
//   Used in testbench for self-checking verification.
// ============================================================

package andlogic_pkg;

    // Base class with virtual compute method
    class LogicBase;
        virtual function logic compute(
            input logic A,
            input logic B,
            input logic C,
            input logic D
        );
        endfunction
    endclass

    // Y1 = A | B  (Left side: Zone A or Zone B fire)
    class Y1Logic extends LogicBase;
        function logic compute(
            input logic A,
            input logic B,
            input logic C,
            input logic D
        );
            return ~(~A & ~B);  // A | B using DeMorgan
        endfunction
    endclass

    // Y2 = C | D  (Right side: Zone C or Zone D fire)
    class Y2Logic extends LogicBase;
        function logic compute(
            input logic A,
            input logic B,
            input logic C,
            input logic D
        );
            return ~(~C & ~D);  // C | D using DeMorgan
        endfunction
    endclass

    // Y3 = (A|B) & (C|D)  (Master alert: 3+ zones active)
    class Y3Logic extends LogicBase;
        function logic compute(
            input logic A,
            input logic B,
            input logic C,
            input logic D
        );
            logic y1 = ~(~A & ~B);
            logic y2 = ~(~C & ~D);
            return y1 & y2;
        endfunction
    endclass

endpackage
