module top_module(
    input x,
    input y,
    output z
);

wire a;
wire b;

// corrected the mistake in assigning inputs to gates
and gate1(a, x, y);
and gate2(b, y, x);
and gate3(z, a, b);

endmodule
