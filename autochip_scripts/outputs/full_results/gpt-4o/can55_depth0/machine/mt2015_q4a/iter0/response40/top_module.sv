module top_module(
	input x,
	input y,
	output z);

    wire xor_out;

    assign xor_out = x ^ y; // XOR operation between x and y
    assign z = xor_out & x; // AND operation between xor_out and x

endmodule
