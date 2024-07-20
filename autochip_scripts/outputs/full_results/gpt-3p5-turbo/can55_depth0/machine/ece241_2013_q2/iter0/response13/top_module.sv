module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
	/* Define wires */
	wire not_a, not_b, not_c, not_d;
	wire pos0, pos1;
	
	/* Assign wire values */
	assign not_a = ~a;
	assign not_b = ~b;
	assign not_c = ~c;
	assign not_d = ~d;
	
	/* Generating out_sop */
	assign out_sop = (c & d) | (not_a & not_b & c);
	
	/* Generating pos0 and pos1 */
	assign pos0 = c & (not_b | d) & (not_a | b);
	assign pos1 = c & (not_a | d);
	
	/* Generating out_pos */
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
	
endmodule
