module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;
    wire c;

    xor gate1(a, x, y);
    or gate2(b, x, y);
    not gate3(z, c);

    and gate4(c, a, b);

endmodule
