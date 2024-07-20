module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire declaration
	wire xor_output;
	
	// XOR gate to obtain the exclusive OR of x and y
	xor x1(
		.x(x),
		.y(y),
		.z(xor_output)
	);
	
	// AND gate to perform the logical AND operation
	and a1(
		.x1(xor_output),
		.x2(x),
		.z(z)
	);
	
endmodule
module xor(
	input x,
	input y,
	output z
);
	assign z = x ^ y;
endmodule
module and(
	input x1,
	input x2,
	output z
);
	assign z = x1 & x2;
endmodule
