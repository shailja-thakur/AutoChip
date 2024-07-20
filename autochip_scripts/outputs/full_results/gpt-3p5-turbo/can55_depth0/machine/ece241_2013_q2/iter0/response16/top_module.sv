module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP expression for out_sop
wire sop_expr1 = c & d;
wire sop_expr2 = (~a & ~b & c);
wire out_sop = sop_expr1 | sop_expr2;

// POS expression for out_pos
wire pos_expr1 = c & (~b | d) & (~a | b);
wire pos_expr2 = c & (~a | d);
wire pos0 = pos_expr1;
wire pos1 = pos_expr2;
wire out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
