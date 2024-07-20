module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Assignments for out_sop output
	wire sop_1 = c & d;  // SOP term 1
	wire sop_2 = ~(a | b) & c;  // SOP term 2
	assign out_sop = sop_1 | sop_2;  // Output is the OR of SOP terms

	// Assignments for out_pos output
	wire pos0 = c & (~b | d);  // POS term 0
	wire pos1 = c & (~a | b);  // POS term 1
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;  // Output assignment using ternary expression

endmodule
