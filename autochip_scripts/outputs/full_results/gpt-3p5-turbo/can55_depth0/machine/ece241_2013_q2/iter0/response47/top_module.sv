module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Define internal wires
	wire sop1;
	wire sop2;
	wire pos0;
	wire pos1;

	// Generate SOP expression for out_sop
	assign sop1 = c & d;
	assign sop2 = ~(a & b & c);
	assign out_sop = sop1 | sop2;

	// Generate POS expression for out_pos
	assign pos0 = c & (b | ~d) & (a | ~b);
	assign pos1 = c & (b | ~a) & (d | ~a);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
