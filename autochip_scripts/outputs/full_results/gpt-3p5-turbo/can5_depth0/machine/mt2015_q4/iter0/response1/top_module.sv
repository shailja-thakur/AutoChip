module top_module (
    input x,
    input y,
    output z
);

// Define intermediate signals
wire a_1, a_2, b_1, b_2;

// Instantiate logic gates
and gate1 (
    .a(x),
    .b(y),
    .z(a_1)
);

and gate2 (
    .a(y),
    .b(x),
    .z(b_1)
);

or gate3 (
    .a(a_1),
    .b(b_1),
    .z(z)
);

endmodule
