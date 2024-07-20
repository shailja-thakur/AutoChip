module top_module(
    input x,
    input y,
    output z
);

    wire xor_out;

    // Implement the XOR operation
    assign xor_out = x ^ y;

    // Implement the AND operation between the XOR output and the first input x
    assign z = xor_out & x;

endmodule
