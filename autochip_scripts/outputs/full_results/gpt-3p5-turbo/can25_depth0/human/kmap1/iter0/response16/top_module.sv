module top_module(
	input a, 
	input b,
	input c,
	output out
);

// define internal signals
wire o;

// implement the Karnaugh map
assign o = (a & ~b & ~c) | (b & c);

// assign output
assign out = o;

endmodule
