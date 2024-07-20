module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Implement the circuit described by the Karnaugh map
	assign out = (!a & !b & !c & b & !d) | (!a & !b & !c & !d) | (!a & !b & c & !d) | (!a & !b & c & b & d) | (!a & b & c & b & d);
	
endmodule
