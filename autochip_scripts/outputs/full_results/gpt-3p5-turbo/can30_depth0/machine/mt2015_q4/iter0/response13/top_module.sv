module top_module(
    input x,
    input y,
    output z
);

wire a;
wire b;

and gate1(a, x, y); // gate1 output is a input for gate3
or gate2(b, x, y); // gate2 output is b input for gate3
and gate3(z, a, b); // gate3 output is z

endmodule
