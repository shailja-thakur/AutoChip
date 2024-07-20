module top_module(
	input x,
	input y,
	output z);

	// Declare internal wires
	wire xor_output;
	
	// XOR gate for inputs x and y
	xor gate1(
		.x(x),
		.y(y),
		.z(xor_output)
	);
	
	// AND gate for XOR output and input x
	and gate2(
		.x(xor_output),
		.y(x),
		.z(z)
	);
	
endmodule
module xor(
	input x,
	input y,
	output z);
	
	assign z = x ^ y;
	
endmodule
module and(
	input x,
	input y,
	output z);
	
	assign z = x & y;
	
endmodule
