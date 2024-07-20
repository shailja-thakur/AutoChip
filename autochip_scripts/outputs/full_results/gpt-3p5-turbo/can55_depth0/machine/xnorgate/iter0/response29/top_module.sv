module top_module(
	input a, 
	input b,
	output out
);
	// logic gate to implement the XOR function
	xor_gate xor_inst(
		.a(a),
		.b(b),
		.out(xor_out)
	);
	
	// logic gate to implement the NOT function
	not_gate not_inst(
		.a(xor_out),
		.out(out)
	);

endmodule
module xor_gate(
	input a,
	input b,
	output out
);
	assign out = a ^ b;
endmodule
module not_gate(
	input a,
	output out
);
	assign out = ~a;
endmodule
