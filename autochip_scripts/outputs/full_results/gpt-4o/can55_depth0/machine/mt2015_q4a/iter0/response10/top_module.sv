module top_module(
	input x,
	input y,
	output z);

    // Intermediate wire for XOR result
    wire xor_result;

    // XOR operation
    assign xor_result = x ^ y;

    // AND operation with the first input
    assign z = xor_result & x;

endmodule
