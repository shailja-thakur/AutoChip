module top_module(
    input x,
    input y,
    output z);

    wire a, b;

    // define the gates
    and gate1(a, x, y);
    or gate2(b, x, y);
    xor gate3(z, a, b);

endmodule
