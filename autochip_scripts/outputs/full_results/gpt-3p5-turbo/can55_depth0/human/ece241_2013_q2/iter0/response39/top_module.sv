module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Function for out_sop output
assign out_sop = (a | b | c | d) & ~(a & ~b & ~c & ~d) & ~(a & b & ~c & ~d) & ~(~a & ~b & c & ~d);

// Function for out_pos output
assign out_pos = (a & b & c & d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (a & ~b & c & ~d) | (a & ~b & ~c & d) | (a & b & ~c & ~d);

endmodule
