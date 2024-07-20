module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    and gate1(a1, x, y);
    and gate2(b1, y, x);
    or gate3(out1, a1, b1);

    and gate4(a2, x, y);
    and gate5(b2, y, x);
    or gate6(out2, a2, b2);

    or gate7(z, out1, out2);

endmodule
