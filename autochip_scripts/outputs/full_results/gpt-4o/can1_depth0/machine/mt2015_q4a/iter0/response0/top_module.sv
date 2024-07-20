module top_module(
	input x,
	input y,
	output z
);

    // The output z is the result of a logical AND operation
    // between the XOR of the two inputs and the first input x
    assign z = (x ^ y) & x;

endmodule
