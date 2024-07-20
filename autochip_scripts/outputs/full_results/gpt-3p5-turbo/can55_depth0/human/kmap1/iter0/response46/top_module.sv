module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Implementing the circuit using the given Karnaugh map
assign out = ((~a & ~b) & (b & ~c)) | ((~a & ~b) & (b & c)) | ((a & b) & (~b & c)) | ((a & b) & (b & c));

endmodule
