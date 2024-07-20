module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // Gate 1
    assign a1 = x;
    assign b1 = y;
    and(out1, a1, b1);

    // Gate 2
    assign a2 = y;
    assign b2 = x;
    and(out2, a2, b2);

    // Gate 3
    and(z, out1, out2);

endmodule
