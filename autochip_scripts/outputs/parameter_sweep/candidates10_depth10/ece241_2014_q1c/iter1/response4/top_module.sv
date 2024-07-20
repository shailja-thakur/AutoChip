module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal signals
	reg signed [8:0] sum; // Sum of a and b (including carry bit)
	reg carry; // Carry out of the most significant bit
	
	// Assign outputs
	assign s = sum[7:0]; // Output the lower 8 bits of the sum
	assign overflow = (carry ^ sum[8]) & (sum[7:0] != 8'b00000000); // Output overflow as the XOR of the carry and MSB, but only if sum is not zero
	
	// Perform the addition operation
	always @(*) begin // Use combinational logic
		sum = a + b; // Add a and b
		
		// Check for carry
		if (sum >= 256) // If the sum is greater than or equal to 256 (which means there was a carry), set carry to 1
			carry = 1'b1;
		else
			carry = 1'b0;
	end
	
endmodule
