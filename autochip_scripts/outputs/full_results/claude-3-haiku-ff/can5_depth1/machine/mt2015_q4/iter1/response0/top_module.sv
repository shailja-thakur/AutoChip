module top_module(
    input x,
    input y,
    output z
);

wire a, b;

// First gate
and(a, x, y);

// Second gate
and(b, x, y);

// Third gate
and(z, a, b);

endmodule
