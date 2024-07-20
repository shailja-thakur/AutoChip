module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Instantiating the circuit
	and gate1 (a, b, w1);
	and gate2 (c, d, w2);
	xor gate3 (w1, w2, q);

	// Internal signals
	wire w1, w2;

endmodule
module and (
	input a,
	input b,
	output out
);

	assign out = a & b;

endmodule
module xor (
	input a,
	input b,
	output out
);

	assign out = a ^ b;

endmodule
