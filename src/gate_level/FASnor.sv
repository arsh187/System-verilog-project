// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : FASnor.sv
// Style    : Gate-Level (NOR gates only)
// Description:
//   Implements fire alarm logic using only NOR gates.
//   NOR is a universal gate — OR and AND are derived from it.
//
//   Logic:
//     Y1 = A | B   => NOR(NOR(A,B), NOR(A,B))  [double NOR = OR]
//     Y2 = C | D   => NOR(NOR(C,D), NOR(C,D))
//     Y3 = Y1 & Y2 => NOR(NOR(A,B), NOR(C,D))  [DeMorgan: NOR of NORs = AND]
// ============================================================

module FASnor (
    input  bit a, b, c, d,
    output bit y1, y2, y3
);

    wire w1, w2;

    // w1 = NOR(a, b)  =>  w1 = ~(a | b)
    nor (w1, a, b);

    // w2 = NOR(c, d)  =>  w2 = ~(c | d)
    nor (w2, c, d);

    // y1 = NOR(w1, w1) = ~(w1 | w1) = ~w1 = a | b
    nor (y1, w1, w1);

    // y2 = NOR(w2, w2) = ~(w2 | w2) = ~w2 = c | d
    nor (y2, w2, w2);

    // y3 = NOR(w1, w2) = ~(~(a|b) | ~(c|d)) = (a|b) & (c|d)
    nor (y3, w1, w2);

endmodule
