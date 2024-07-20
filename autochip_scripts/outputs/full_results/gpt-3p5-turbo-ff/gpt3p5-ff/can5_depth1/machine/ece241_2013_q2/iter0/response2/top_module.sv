module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Declare intermediate wires
	wire sop0, sop1, pos0, pos1;
	
	// Generate the SOP expression for out_sop
	assign sop0 = c & d;
	assign sop1 = (~a & ~b & c);
	assign out_sop = sop0 | sop1;
	
	// Generate the POS expression for out_pos
	assign pos0 = c & (~b | d);
	assign pos1 = (~a | b) & (~a | d);
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
	
endmodule
