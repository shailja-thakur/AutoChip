module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP expression for out_sop
wire sop_temp1 = c & d;
wire sop_temp2 = (~a & ~b & c);
assign out_sop = sop_temp1 | sop_temp2;

// POS expression for out_pos
wire pos0 = c & (~b | d) & (~a | ~b);
wire pos1 = c & (~a | d);
assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
