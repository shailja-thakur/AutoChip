module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
	// intermediate wires for the combinational logic
	wire sop0, sop1, pos0, pos1;
	
	// logic for out_sop
	assign sop0 = c & d;
	assign sop1 = (~a & ~b & c);
	assign out_sop = sop0 | sop1;
	
	// logic for out_pos
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);
	assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;
	
endmodule
