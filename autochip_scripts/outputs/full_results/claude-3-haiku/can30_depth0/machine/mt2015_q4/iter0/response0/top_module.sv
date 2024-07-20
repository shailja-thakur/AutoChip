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
    assign a2 = y;
    assign b2 = x;
    and(out2, a2, b2);

    // Third gate
    and(z, out1, out2);

endmodule
