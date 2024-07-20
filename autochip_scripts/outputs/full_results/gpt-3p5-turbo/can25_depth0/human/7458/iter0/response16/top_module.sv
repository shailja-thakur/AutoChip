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

// AND gates
and #(3) and1 (p1and1, p1a, p1b, p1c);
and #(3) and2 (p1and2, p1d, p1e, p1f);
and #(2) and3 (p2and1, p2a, p2b);
and #(2) and4 (p2and2, p2c, p2d);

// OR gates
or #(2) or1 (p1y, p1and1, p1and2);
or #(2) or2 (p2y, p2and1, p2and2);

endmodule
