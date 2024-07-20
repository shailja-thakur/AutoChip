module top_module(
    input x,
    input y,
    output z
);

    wire xor_result;

    // Implement the XOR operation between x and y
    assign xor_result = x ^ y;

    // Implement the AND operation between x and the XOR result
    assign z = x & xor_result;

endmodule
