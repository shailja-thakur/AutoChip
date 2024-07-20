module top_module(
    input x,
    input y,
    output z);

    wire n1, n2;

    // First gate - Let's use an AND gate
    and g1(n1, x, y);

    // Second gate - Let's use an OR gate
    or g2(n2, x, y);

    // Third gate - Let's use a NAND gate
    nand g3(z, n1, n2);

endmodule
