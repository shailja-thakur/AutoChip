module top_module(
	input x,
	input y,
	output z);
	
	// Intermediate signals
	wire xor_result;
	
	// XOR gate
	xor_gate xor1(
		.x(x),
		.y(y),
		.z(xor_result)
	);
	
	// NOT gate
	not_gate not1(
		.x(xor_result),
		.z(z)
	);
	
endmodule
module xor_gate(
	input x,
	input y,
	output z);
	
	// Intermediate signals
	wire wire1, wire2;
	
	// AND gate
	and_gate and1(
		.x(x),
		.y(~y),
		.z(wire1)
	);
	
	// AND gate
	and_gate and2(
		.x(~x),
		.y(y),
		.z(wire2)
	);
	
	// OR gate
	or_gate or1(
		.x(wire1),
		.y(wire2),
		.z(z)
	);
	
endmodule
module not_gate(
	input x,
	output z);
	
	// NOT gate
	assign z = ~x;
	
endmodule
module and_gate(
	input x,
	input y,
	output z);
	
	// AND gate
	assign z = x & y;
	
endmodule
module or_gate(
	input x,
	input y,
	output z);
	
	// OR gate
	assign z = x | y;
	
endmodule
