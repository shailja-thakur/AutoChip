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

// Intermediate wires for the internal AND gates
wire and1_output;
wire and2_output;
wire and3_output;
wire and4_output;

// AND gate 1: p1a, p1b, p1c
and gate1(and1_output, p1a, p1b, p1c);

// AND gate 2: p1d, p1e, p1f
and gate2(and2_output, p1d, p1e, p1f);

// AND gate 3: p2a, p2b
and gate3(and3_output, p2a, p2b);

// AND gate 4: p2c, p2d
and gate4(and4_output, p2c, p2d);

// OR gate 1: and1_output, and2_output
or gate5(p1y, and1_output, and2_output);

// OR gate 2: and3_output, and4_output
or gate6(p2y, and3_output, and4_output);

endmodule
