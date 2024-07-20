module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    and gate1(a, x, y);
    assign gate1out = a;

    or gate2(b, y, x);
    assign gate2out = b;

    or gate3(z, gate1out, gate2out);

endmodule
