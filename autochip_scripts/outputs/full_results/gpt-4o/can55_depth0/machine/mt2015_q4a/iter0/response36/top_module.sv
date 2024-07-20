module top_module(
	input x,
	input y,
	output z);

    // Intermediate wire to hold the result of XOR operation
    wire xor_result;

    // Perform XOR operation on inputs x and y
    assign xor_result = x ^ y;

    // Perform AND operation between the XOR result and input x
    assign z = xor_result & x;

endmodule
