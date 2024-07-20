module top_module(
	input a, 
	input b,
	output out
);

	// Implement a NOR gate using a combination of a NOT gate and an OR gate
	wire not_a, not_b;
	not_gate u1(.a(a), .out(not_a));
	not_gate u2(.a(b), .out(not_b));
	or_gate u3(.a(not_a), .b(not_b), .out(out));

endmodule
module not_gate(
	input a,
	output out
);
	assign out = ~a;
endmodule
module or_gate(
	input a,
	input b,
	output out
);
	assign out = a | b;
endmodule
