module top_module(
	input a, 
	input b,
	output out
);

	// Declare signals
	wire a_not, b_not;
	
	// Instantiate inverters
	not_gate not1 (.in(a), .out(a_not));
	not_gate not2 (.in(b), .out(b_not));
	
	// Instantiate XNOR gate
	xnor_gate xnor1 (.a(a_not), .b(b_not), .out(out));
	
endmodule
module not_gate (
	input in,
	output out
);
	
	assign out = ~in;
	
endmodule
module xnor_gate (
	input a,
	input b,
	output out
);
	
	assign out = ~(a ^ b);
	
endmodule
