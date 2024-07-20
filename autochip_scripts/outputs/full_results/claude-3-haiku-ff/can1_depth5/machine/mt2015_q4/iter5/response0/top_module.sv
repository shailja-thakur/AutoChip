module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    assign a1 = x;
    assign b1 = y;
    and(out1, a1, b1);

    // Second gate
    assign a2 = x;
    assign b2 = y;
    and(out2, a2, b2);

    // Third gate
    or(z, out1, out2);

endmodule
