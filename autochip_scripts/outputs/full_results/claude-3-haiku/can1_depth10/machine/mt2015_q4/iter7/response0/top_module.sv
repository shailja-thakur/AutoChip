module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, out1, out2;

    // First gate
    assign a1 = x;
    assign b1 = y;

    // Second gate 
    assign a2 = ~x;
    assign b2 = y;

    // Third gate
    assign out1 = a1 | b1;
    assign out2 = a2 | b2;
    assign z = out1 & out2;

endmodule
