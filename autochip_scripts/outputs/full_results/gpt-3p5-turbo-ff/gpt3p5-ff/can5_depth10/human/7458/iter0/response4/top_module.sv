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

// Intermediate wires for internal signals
wire p1a_and_b_c;
wire p1d_and_e_f;

// AND gates
assign p1a_and_b_c = p1a & p1b & p1c;
assign p1d_and_e_f = p1d & p1e & p1f;

// OR gates
assign p1y = p1a_and_b_c | p1d_and_e_f;
assign p2y = p2a & p2b | p2c & p2d;

endmodule
