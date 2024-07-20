module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Use intermediate wires to break down the complex expressions
	wire sop1, sop2, pos0, pos1;

	// Generate out_sop output
	assign sop1 = c & d;
	assign sop2 = (~a & ~b & c);
	assign out_sop = sop1 | sop2;

	// Generate out_pos output
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);

	assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
