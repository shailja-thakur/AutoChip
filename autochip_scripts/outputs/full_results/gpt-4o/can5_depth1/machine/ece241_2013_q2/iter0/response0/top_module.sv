module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

wire not_a, not_b;
wire sop0, sop1;
wire pos0, pos1;

// Generate intermediate terms
assign not_a = ~a;
assign not_b = ~b;

// Sum-of-Products (SOP) expression generation
assign sop0 = c & d;
assign sop1 = not_a & not_b & c;
assign out_sop = sop0 | sop1;

// Product-of-Sums (POS) expression generation
assign pos0 = c & (~b | d) & (~a | b);
assign pos1 = c & (~b | d) & (~a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
