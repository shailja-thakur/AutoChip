module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Intermediate wires for the internal signals
	wire and1_output, and2_output, and3_output, and4_output;

	// AND gates
	and_gate u1 (.p1(p1a), .p2(p1b), .p3(p1c), .p(and1_output));
	and_gate u2 (.p1(p1d), .p2(p1e), .p3(p1f), .p(and2_output));
	and_gate u3 (.p1(p2a), .p2(p2b), .p3(), .p(and3_output));
	and_gate u4 (.p1(p2c), .p2(p2d), .p3(), .p(and4_output));
	
	// OR gates
	or_gate u5 (.p1(and1_output), .p2(and2_output), .p(p1y));
	or_gate u6 (.p1(and3_output), .p2(and4_output), .p(p2y));

endmodule
module and_gate (
	input p1,
	input p2,
	input p3,
	output p
);

	assign p = p1 & p2 & p3;

endmodule
module or_gate (
	input p1,
	input p2,
	output p
);

	assign p = p1 | p2;

endmodule
