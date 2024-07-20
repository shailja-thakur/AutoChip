module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);

	// Declare internal signals
	reg signed [8:0] sum; // Sum of a and b (including carry bit)
	reg carry; // Carry out of the most significant bit
	
	// Assign outputs
	assign s = sum[7:0]; // Output the lower 8 bits of the sum
	assign overflow = carry ^ sum[8]; // Output overflow as the XOR of the carry and MSB
	
	// Perform the addition operation
	always @(a, b) begin // Use combinational logic
		sum = a + b; // Add a and b
		
		// Check for carry
		if (sum[8] == 1'b1) // MSB is 1
			carry = 1'b1; // Set carry to 1
		else
			carry = 1'b0; // Set carry to 0
	end
	
endmodule
