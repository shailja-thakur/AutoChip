module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and gate1(out1, x, y);
    or gate2(out2, x, y);  // Changed from nand to or
    nand gate3(z, out1, out2);  // Changed from or to nand

endmodule
