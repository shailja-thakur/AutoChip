module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Define the internal wire signals
	wire w1, w2, w3, w4;

	// Implement the logic for the internal wires
	assign w1 = d;
	assign w2 = (c & ~d);
	assign w3 = (b & ~c & d);
	assign w4 = (a & ~b & c & ~d);

	// Implement the logic for the output
	assign q = (w1 | w2 | w3 | w4);

endmodule
