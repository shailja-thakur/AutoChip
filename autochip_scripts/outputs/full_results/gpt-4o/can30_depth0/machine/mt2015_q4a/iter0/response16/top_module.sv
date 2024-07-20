module top_module(
	input x,
	input y,
	output z);

    // XOR operation between x and y
    wire xor_xy;
    assign xor_xy = x ^ y;

    // AND operation between xor_xy and x
    assign z = xor_xy & x;

endmodule
