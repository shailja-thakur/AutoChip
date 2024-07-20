module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implementing the circuit using logical operators
assign out = (~a & ~b & ~c & d) | (~a & ~b & c & d) | (a & ~b & c & ~d) | (~a & b & ~c & d) | (a & b & ~c & ~d);

endmodule
