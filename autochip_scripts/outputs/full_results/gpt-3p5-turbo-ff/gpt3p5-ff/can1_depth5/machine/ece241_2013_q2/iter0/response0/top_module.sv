module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP expression: out_sop = (c & d) | ((!a & !b) & c)
wire sop;
assign sop = (c & d) | ((!a & !b) & c);
assign out_sop = sop;

// POS expression: out_pos = ((c & (!b | d)) | ((!a & b) & (!a | d))) ? ((c & (!b | d)) | ((!a & b) & (!a | d))) : 1'bx;
wire pos0, pos1;
assign pos0 = (c & (!b | d)) | ((!a & b) & (!a | d));
assign pos1 = (c & (!b | d)) | ((!a & d));
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
