module top_module(
    input x,
    input y,
    output z
);

    // Implement the logic for the output z
    assign z = (x ^ y) & x;

endmodule
