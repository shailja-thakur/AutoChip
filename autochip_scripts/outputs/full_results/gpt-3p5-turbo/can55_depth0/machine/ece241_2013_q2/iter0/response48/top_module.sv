module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Intermediate wires for SOP expression
	wire sop1;
	wire sop2;
	wire sop3;

	// Intermediate wires for POS expression
	wire pos0;
	wire pos1;

	// Calculate out_sop
	assign sop1 = c & d;
	assign sop2 = ~a & ~b & c;
	assign out_sop = sop1 | sop2;

	// Calculate pos0 and pos1 for out_pos
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);

	// Calculate out_pos using ternary operator
	assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
