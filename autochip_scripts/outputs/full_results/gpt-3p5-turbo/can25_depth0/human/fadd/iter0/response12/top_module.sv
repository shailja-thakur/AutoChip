module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal signals
	wire w1, w2, w3;
	
	// Instantiate XOR and AND gates
	xor_gate xor1 (a, b, w1);
	xor_gate xor2 (w1, cin, sum);
	and_gate and1 (a, b, w2);
	and_gate and2 (a, cin, w3);
	and_gate and3 (w1, cin, cout);
	or_gate or1 (w2, w3, cout);
	
endmodule
module xor_gate (
	input a,
	input b,
	output x
);
	
	assign x = a ^ b;
	
endmodule
module and_gate (
	input a,
	input b,
	output y
);
	
	assign y = a & b;
	
endmodule
module or_gate (
	input a,
	input b,
	output z
);
	
	assign z = a | b;
	
endmodule
