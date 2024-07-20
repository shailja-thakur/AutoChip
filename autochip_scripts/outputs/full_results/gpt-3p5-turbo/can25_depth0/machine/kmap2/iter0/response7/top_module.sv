module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Assign the output signal using the specified logic function
assign out = (!(b && c)) || (!(a && d)) || (a && c && d) || (b && c && d);

endmodule
