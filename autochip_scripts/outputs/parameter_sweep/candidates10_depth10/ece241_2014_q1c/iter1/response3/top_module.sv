module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal signals
	wire signed [8:0] sum; // Sum of a and b (including carry bit)
	wire carry; // Carry out of the most significant bit
	
	// Assign outputs
	assign s = sum[7:0]; // Output the lower 8 bits of the sum
	assign overflow = carry ^ sum[8]; // Output overflow as the XOR of the carry and MSB
	
	// Perform the addition operation
	assign {carry, sum[7:0]} = a + b; // Add a and b

endmodule
