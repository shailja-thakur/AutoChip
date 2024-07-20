module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to store the XOR of x and y
	wire xor_output;
	
	// Intermediate wire to store the AND of xor_output and x
	wire and_output;
	
	// XOR gate to calculate the XOR of x and y
	xor u1(
		.x1(x),
		.x2(y),
		.y(xor_output)
	);
	
	// AND gate to calculate the AND of xor_output and x
	and u2(
		.x1(xor_output),
		.x2(x),
		.y(and_output)
	);
	
	// Assigning the value of and_output to z
	assign z = and_output;
	
endmodule
module xor(
	input x1,
	input x2,
	output y);
	
	assign y = x1 ^ x2;
	
endmodule
module and(
	input x1,
	input x2,
	output y);
	
	assign y = x1 & x2;
	
endmodule
