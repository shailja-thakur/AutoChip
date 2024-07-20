module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// SOP Expression
assign out_sop = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & b & c & ~d) | (~a & b & c & d) | (a & ~b & ~c & ~d) | (a & b & ~c & ~d) | (a & ~b & ~c & d) | (a & ~b & c & ~d);

// POS Expression
assign out_pos = (a + b + c + d) * (~a + ~b + c + ~d) * (~a + b + ~c + ~d) * (~a + b + ~c + d) * (~a + ~b + ~c + d) * (a + ~b + ~c + ~d) * (a + b + ~c + ~d) * (~a + ~b + c + d) * (~a + ~b + ~c + ~d);

endmodule
