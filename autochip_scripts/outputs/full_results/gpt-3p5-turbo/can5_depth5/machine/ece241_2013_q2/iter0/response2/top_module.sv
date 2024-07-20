module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
	// Define internal wires
	wire sop1, sop2, sop3, pos0, pos1;

	// SOP output calculation
	assign sop1 = ~a & ~b & c;
	assign sop2 = c & d;
	assign sop3 = sop1 | sop2;
	assign out_sop = sop3;

	// POS output calculation
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);
	assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
