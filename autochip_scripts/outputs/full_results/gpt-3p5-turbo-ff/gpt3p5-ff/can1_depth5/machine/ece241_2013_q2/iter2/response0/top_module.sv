module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP expression: out_sop = (c & d) | ((!a & !b) & c)
wire [1:0] sop;
assign sop = {(c & d), ((!a & !b) & c)};
assign out_sop = sop[1] | sop[0];

// POS expression: out_pos = ((c & (!b | d)) | ((!a & b) & (!a | d))) ? ((c & (!b | d)) | ((!a & b) & (!a | d))) : 1'bx;
wire [1:0] pos;
assign pos[0] = (c & (!b | d)) | ((!a & b) & (!a | d));
assign pos[1] = (c & (!b | d)) | ((!a & d));
assign out_pos = (pos[1] == pos[0]) ? pos[0] : 1'bx;

endmodule
