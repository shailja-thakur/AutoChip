module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Define internal signals
	wire w1, w2, w3, w4;

	// Implement the Karnaugh map logic
	assign w1 = ~a & ~b & ~c & d;
	assign w2 = ~a & ~b & c & ~d;
	assign w3 = a & ~b & ~c & d;
	assign w4 = a & ~b & ~c & ~d;

	// Combine the outputs using OR gates
	assign out = w1 | w2 | w3 | w4;
	
endmodule
