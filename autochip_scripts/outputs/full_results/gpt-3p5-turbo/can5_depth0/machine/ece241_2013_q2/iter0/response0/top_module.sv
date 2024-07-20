module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP expression for out_sop
wire sop0 = a & b & c;
wire sop1 = ~a & ~b & c;
wire sop2 = c & d;
assign out_sop = sop0 | sop1 | sop2;

// POS expression for out_pos
wire pos0 = c & (~b | d) & (~a | b);
wire pos1 = c & (~a | b) & (~a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bX;

endmodule
