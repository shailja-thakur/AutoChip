module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Define internal wires
	wire sop, pos0, pos1;

	// Define internal signals
	assign sop = (c & d) | ((~a & ~b) & c);
	assign pos0 = c & (~b | d) | (~a & b);
	assign pos1 = c & (~a | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

	// Assign outputs
	assign out_sop = sop;
endmodule
