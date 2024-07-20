module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    and(a1, x, y);
    and(b1, y, x);
    or(out1, a1, b1);

    // Second gate  
    and(a2, y, x);
    and(b2, x, y);
    or(out2, a2, b2);

    // Third gate
    or(z, out1, out2);

endmodule
