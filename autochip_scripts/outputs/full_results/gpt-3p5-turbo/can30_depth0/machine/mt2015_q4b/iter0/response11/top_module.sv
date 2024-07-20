module top_module(
	input x,
	input y,
	output z);

	// intermediate signal to store XOR of x and y
	wire xor_out;

	// xor gate
	xor_gate xor_inst (
		.x(x),
		.y(y),
		.z(xor_out)
	);

	// not gate
	not_gate not_inst (
		.x(xor_out),
		.z(z)
	);
	
endmodule
module xor_gate(
	input x,
	input y,
	output z);
	
	assign z = x ^ y;
	
endmodule
module not_gate(
	input x,
	output z);
	
	assign z = ~x;
	
endmodule
