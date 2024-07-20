module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    and(out1, x, y);

    // Second gate    
    and(out2, y, x);

    // Third gate
    and(z, out1, out2);

endmodule
