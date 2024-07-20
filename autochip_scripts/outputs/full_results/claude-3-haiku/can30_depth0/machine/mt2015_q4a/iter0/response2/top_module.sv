module top_module(
    input x,
    input y,
    output z
);

    // Calculate the XOR of x and y
    wire xor_xy;
    assign xor_xy = x ^ y;

    // Compute the logical AND between xor_xy and x
    assign z = xor_xy & x;

endmodule
