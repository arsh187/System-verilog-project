// ============================================================
// Project  : SystemVerilog-Based Fire Alarm System
// File     : mygate.sv  (mygate package)
// Style    : Gate-Level - OOP Reference Model Package
// Description:
//   NOR gate class used in the gate-level testbench
//   to build a software reference model that mirrors
//   the hardware NOR gate network in FASnor.sv.
// ============================================================

package mygate;

    class norgate;

        bit i1, i2;  // Inputs
        bit o1;      // Output

        // Constructor: takes two input bits
        function new(bit t1, bit t2);
            i1 = t1;
            i2 = t2;
        endfunction

        // Perform NOR logic: o1 = ~(i1 | i2)
        function void performlogic();
            o1 = ~(i1 | i2);
        endfunction

    endclass

endpackage
