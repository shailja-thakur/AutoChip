module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Create intermediate signals for each entry in the Karnaugh map
	wire p1, p2, p3, p4, p5, p6, p7, p8;

	// Implement the logic for each intermediate signal
	assign p1 = a & b & ~c & d;
	assign p2 = a & ~b & ~c & d;
	assign p3 = ~a & b & ~c & d;
	assign p4 = a & b & c & d;
	assign p5 = a & b & c & ~d;
	assign p6 = ~a & b & c & ~d;
	assign p7 = a & ~b & c & ~d;
	assign p8 = ~a & ~b & ~c & d;

	// Implement the final output based on the intermediate signals
	assign out = p1 | p2 | p3 | p4 | p5 | p6 | p7 | p8;

endmodule
