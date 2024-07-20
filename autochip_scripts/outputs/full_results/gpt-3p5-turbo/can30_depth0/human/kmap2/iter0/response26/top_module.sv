module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implementing the circuit using the Karnaugh map

assign out = (a & b) | (~c & d);  // Karnaugh map entries

endmodule
