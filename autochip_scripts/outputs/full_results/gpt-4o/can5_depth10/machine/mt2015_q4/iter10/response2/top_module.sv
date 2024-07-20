module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and gate1(out1, x, y);   // First gate is an AND gate
    or gate2(out2, x, y);    // Second gate is an OR gate
    nand gate3(z, out1, out2); // Third gate is a NAND gate

endmodule
