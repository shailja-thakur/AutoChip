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
	and gate1(and1_out, p1a, p1b, p1c);
	and gate2(and2_out, p1d, p1e, p1f);
	and gate3(and3_out, p2a, p2b);
	and gate4(and4_out, p2c, p2d);
	
	// OR gates
	or or1(p1y, and1_out, and2_out);
	or or2(p2y, and3_out, and4_out);

endmodule
module and(
	output o,
	input i1,
	input i2,
	input i3
);
	assign o = i1 & i2 & i3;
endmodule
module or(
	output o,
	input i1,
	input i2
);
	assign o = i1 | i2;
endmodule
