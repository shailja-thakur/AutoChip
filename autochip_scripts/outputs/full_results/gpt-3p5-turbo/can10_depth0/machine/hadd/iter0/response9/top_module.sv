module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Define internal wires for carry calculation
	wire c1, c2;

	// Implement full adder logic
	assign sum = a ^ b ^ c1;
	assign cout = (a & b) | (c1 & (a ^ b));

endmodule
