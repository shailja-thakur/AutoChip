module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate: AND gate (can be replaced with other gates like OR, NAND, etc. if needed)
    and g1 (out1, x, y);

    // Second gate: OR gate (can be replaced with other gates like AND, NAND, etc. if needed)
    or g2 (out2, x, y);

    // Third gate: NAND gate (can be replaced with other gates like AND, OR, etc. if needed)
    nand g3 (z, out1, out2);

endmodule
