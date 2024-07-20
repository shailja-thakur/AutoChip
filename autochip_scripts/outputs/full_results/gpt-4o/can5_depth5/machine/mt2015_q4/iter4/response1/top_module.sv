module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate (AND gate)
    assign out1 = x & y;

    // Second gate (AND gate)
    assign out2 = x | y;

    // Third gate (NAND gate)
    assign z = !(out1 & out2);

endmodule
