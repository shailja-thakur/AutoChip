module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Use the logical OR operation to calculate the output signal
	assign out = (~c & ~b) | (~d & ~a) | (a & c & d) | (b & c & d);

endmodule
