module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Logic to determine out_sop
assign out_sop = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (a & ~b & ~c & ~d);

// Logic to determine out_pos
assign out_pos = (a | b | c | ~d) & (a | b | ~c | d) & (a | ~b | c | d) & (~a | b | c | d);

endmodule
