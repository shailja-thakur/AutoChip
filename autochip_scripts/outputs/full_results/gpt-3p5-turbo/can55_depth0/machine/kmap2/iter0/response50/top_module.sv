module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Logic to calculate the output signal
	assign out = | (a & c & d) | (b & c & d) | (!c & !b) | (!d & !a);

endmodule
