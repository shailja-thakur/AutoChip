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
	assign overflow = (carry ^ sum[8]) && (sum[8] != sum[7]); // Output overflow as the XOR of the carry and MSB, but only if MSB is not equal to the second most significant bit
	
	// Perform the addition operation
	always @(a or b) begin // Use combinational logic
		// Extend a and b to 9 bits for signed arithmetic
		reg signed [8:0] extended_a = {{1'b0}, a};
		reg signed [8:0] extended_b = {{1'b0}, b};
		
		// Calculate the sum and carry
		sum = extended_a + extended_b;
		carry = sum[8]; // Carry out of the most significant bit
	end
	
endmodule
