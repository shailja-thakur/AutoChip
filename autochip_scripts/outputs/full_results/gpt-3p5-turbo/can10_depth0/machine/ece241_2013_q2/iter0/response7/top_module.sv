module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
	// Intermediate wires
	wire s0, s1, p0, p1;
	
	// Generate out_sop logic
	assign s0 = c & d;
	assign s1 = (~a & ~b & c);
	assign out_sop = s0 | s1;
	
	// Generate out_pos logic
	assign p0 = c & (~b | d) & (~a | b);
	assign p1 = c & (~a | d);
	assign out_pos = (p0 == p1) ? p0 : 1'bx;
	
endmodule
