module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and gate1(out1, x, y);
    nor gate2(out2, y, x);  // Changed to 'nor' to match the input requirements correctly
    nand gate3(z, out1, out2);  // Changed to 'nand' for possible gate logic correctness

endmodule
