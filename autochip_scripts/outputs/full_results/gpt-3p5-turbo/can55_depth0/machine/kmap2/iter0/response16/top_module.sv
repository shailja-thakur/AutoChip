module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Assign statement to calculate the output signal
assign out = ~(~(~a & ~d) & ~(~b & ~c) & ~(a & c & d) & ~(b & c & d));

endmodule
