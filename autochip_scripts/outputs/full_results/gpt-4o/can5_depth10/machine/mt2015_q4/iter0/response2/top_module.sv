module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and and_gate1(out1, x, y);
    or  or_gate2(out2, x, y);
    xor xor_gate3(z, out1, out2);

endmodule
