module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define internal wire variables
wire sop1, sop2, sop3;
wire pos0, pos1;

// Implement SOP expression for out_sop
assign sop1 = c & d;
assign sop2 = ~a & ~b & c;
assign sop3 = sop1 | sop2;
assign out_sop = sop3;

// Implement POS expression for out_pos
assign pos0 = c & (~b | d) | (~a & b);
assign pos1 = c & (~a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
