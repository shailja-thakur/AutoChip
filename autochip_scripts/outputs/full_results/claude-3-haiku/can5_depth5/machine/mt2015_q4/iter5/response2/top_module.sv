module top_module(
    input x,
    input y,
    output z
);

wire a, b;

// First gate
and(a, x, y); // Corrected the order of inputs to the first and gate

// Second gate
and(b, y, x); // Corrected the order of inputs to the second and gate

// Third gate
or(z, a, b);

endmodule
