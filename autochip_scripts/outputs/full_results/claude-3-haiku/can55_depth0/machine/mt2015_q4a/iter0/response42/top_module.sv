module top_module(
    input x,
    input y,
    output z
);

    // Implement the logic
    assign z = (x ^ y) & x;

endmodule
