module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

wire sop1;
wire sop2;
wire pos0;
wire pos1;

// SOP expression
assign sop1 = c & d;
assign sop2 = (~a & ~b & c);
assign out_sop = sop1 | sop2;

// POS expression
assign pos0 = c & (~b | d);
assign pos1 = c & (~a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
