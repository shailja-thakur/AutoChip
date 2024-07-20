module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, a3, b3;

    // First gate
    and(a1, x, y);
    and(b1, y, x);

    // Second gate    
    and(a2, y, x);
    and(b2, x, y);

    // Third gate
    and(a3, a1, b2);
    and(b3, b1, a2);
    or(z, a3, b3);

endmodule
