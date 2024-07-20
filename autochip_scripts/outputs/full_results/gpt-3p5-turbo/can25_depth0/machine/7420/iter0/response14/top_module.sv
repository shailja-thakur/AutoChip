module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

// Internal wires
wire p1, p2;

// Logic gates for p1y output
and #(4) and_gate_p1 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .q(p1)
);

not not_gate_p1 (
    .a(p1),
    .q(p1y)
);

// Logic gates for p2y output
and #(4) and_gate_p2 (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .q(p2)
);

not not_gate_p2 (
    .a(p2),
    .q(p2y)
);

endmodule
