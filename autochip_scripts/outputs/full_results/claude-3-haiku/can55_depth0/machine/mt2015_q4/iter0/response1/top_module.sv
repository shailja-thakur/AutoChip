module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2, out3;

// First gate
and(a1, x, y);
or(b1, x, y);

// Second gate
or(a2, x, y);
and(b2, x, y);

// Third gate
and(out3, a1, b2);
or(z, out3, b1);

endmodule
