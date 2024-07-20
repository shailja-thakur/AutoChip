module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    assign a1 = x & y;
    assign b1 = x & ~y;

    // Second gate 
    assign a2 = ~x & y;
    assign b2 = x & y;

    // Third gate
    assign out1 = a1 | b1;
    assign out2 = a2 | b2;
    assign z = out1 | out2;

endmodule
