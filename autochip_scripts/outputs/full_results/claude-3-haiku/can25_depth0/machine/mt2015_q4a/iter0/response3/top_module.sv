module top_module(
    input x,
    input y,
    output z
);

    wire xor_output;

    // Implement the XOR operation
    assign xor_output = x ^ y;

    // Implement the AND operation between the XOR output and the first input x
    assign z = xor_output & x;

endmodule
