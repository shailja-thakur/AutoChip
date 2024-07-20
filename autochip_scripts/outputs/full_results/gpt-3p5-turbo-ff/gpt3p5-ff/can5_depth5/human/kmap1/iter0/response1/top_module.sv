module top_module(
	input a, 
	input b,
	input c,
	output out
);
	// assign the output based on the Karnaugh map
	assign out = (a & !b & c) | (!a & b & c) | (!a & b & !c) | (!a & !b & c) | (!a & !b & !c);
endmodule
