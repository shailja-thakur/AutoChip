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
	
	// Internal wires
	wire and1_out;
	wire and2_out;
	wire and3_out;
	wire and4_out;
	
	// AND gates
	and_gate and1 (.o(and1_out), .i1(p1a), .i2(p1b), .i3(p1c));
	and_gate and2 (.o(and2_out), .i1(p1d), .i2(p1e), .i3(p1f));
	and_gate and3 (.o(and3_out), .i1(p2a), .i2(p2b));
	and_gate and4 (.o(and4_out), .i1(p2c), .i2(p2d));
	
	// OR gates
	or_gate or1 (.o(p1y), .i1(and1_out), .i2(and2_out));
	or_gate or2 (.o(p2y), .i1(and3_out), .i2(and4_out));

endmodule
module and_gate(
	output o,
	input i1,
	input i2,
	input i3
);
	assign o = i1 & i2 & i3;
endmodule
module or_gate(
	output o,
	input i1,
	input i2
);
	assign o = i1 | i2;
endmodule
