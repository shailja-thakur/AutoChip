module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// internal wires for intermediate signals
	wire carry;
	
	// Adder logic
	assign sum = a + b;
	assign cout = carry;
	
endmodule
