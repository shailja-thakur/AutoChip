module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

wire not_a, not_b;
wire and1, and2;
wire or1, pos0, pos1;

// Generate the NOT gates
assign not_a = ~a;
assign not_b = ~b;

// Generate the AND gates for SOP
assign and1 = c & d;
assign and2 = not_a & not_b & c;

// Generate the out_sop
assign or1 = and1 | and2;
assign out_sop = or1;

// Generate the POS gates
assign pos0 = c & (not_b | d) & (not_a | b);
assign pos1 = c & (not_a | d);

// Assign the out_pos
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
