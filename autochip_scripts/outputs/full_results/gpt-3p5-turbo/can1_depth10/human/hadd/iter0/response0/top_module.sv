module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Declare internal wires
	wire s, c;
	
	// Create half adder logic
	assign s = a ^ b;
	assign c = a & b;
	
	// Assign outputs
	assign sum = s;
	assign cout = c;
endmodule
