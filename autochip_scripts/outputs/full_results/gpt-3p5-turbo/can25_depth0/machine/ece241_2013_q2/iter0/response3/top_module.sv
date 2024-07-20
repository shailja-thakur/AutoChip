module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// SOP output assignment
	assign out_sop = (c & d) | ((!a & !b & c));

	// POS output assignments
	wire pos0, pos1;
	assign pos0 = c & (!b | d) & (!a | b);
	assign pos1 = c & (!a | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
endmodule
