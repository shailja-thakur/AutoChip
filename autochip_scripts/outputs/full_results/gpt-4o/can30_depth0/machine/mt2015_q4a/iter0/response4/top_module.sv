module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire for the XOR operation
    wire xor_result;

    // Perform the XOR operation
    assign xor_result = x ^ y;

    // Perform the AND operation between XOR result and x
    assign z = xor_result & x;

endmodule
