module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wire
	wire s, c;
	
	// Implement XOR gate for sum
	xor(s, a, b);
	
	// Implement AND gate for carry-out
	and(c, a, b);
	
	// Assign outputs to internal wires
	assign sum = s;
	assign cout = c;
	
endmodule
