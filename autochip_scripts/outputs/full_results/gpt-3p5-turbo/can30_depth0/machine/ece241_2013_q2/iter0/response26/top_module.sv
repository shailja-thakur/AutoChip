module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Wire to store intermediate calculation for out_sop
	wire sop;

	// Wire to store intermediate calculation for pos0 and pos1
	wire pos0;
	wire pos1;

	// Logic for out_sop
	assign sop = (c & d) | ((!a & !b & c));

	// Logic for pos0 and pos1
	assign pos0 = (c & (!b | d) | (!a & b));
	assign pos1 = (c & (!a | d));

	// Logic for out_pos
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

	// Assign out_sop to out_sop output
	assign out_sop = sop;

endmodule
