module top_module(
    input x,
    input y,
    output z
);

    assign z = (x & ~y) ^ (~x & y);  // XOR gate to calculate z

endmodule
