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

	// Intermediate wires
	wire p1and1;
	wire p1and2;
	wire p2and1;
	wire p2and2;

	// Connection statements
	assign p1y = p1and1 | p1and2;
	assign p2y = p2and1 | p2and2;

	// AND gate connections
	and gate_p1and1(p1and1, p1a, p1b, p1c);
	and gate_p1and2(p1and2, p1d, p1e, p1f);
	and gate_p2and1(p2and1, p2a, p2b);
	and gate_p2and2(p2and2, p2c, p2d);

endmodule
module and(
	output and_out,
	input and_in1,
	input and_in2,
	input and_in3
);
	assign and_out = and_in1 & and_in2 & and_in3;
endmodule
module or(
	output or_out,
	input or_in1,
	input or_in2
);
	assign or_out = or_in1 | or_in2;
endmodule
