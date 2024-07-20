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
	assign overflow = carry ^ sum[8]; // Output overflow as the XOR of the carry and MSB
	
	// Perform the addition operation
	always @(*) begin // Use combinational logic
		// Check for carry
		if (a[7] == 1'b0 && b[7] == 1'b0)
			carry = 1'b0; // No carry
		else if (a[7] == 1'b1 && b[7] == 1'b1)
			carry = 1'b1; // Carry
		else if (a[7] == 1'b0 && b[7] == 1'b1) begin
			if (a[6:0] + (~b[6:0] + 1) >= 8'b10000000) // MSB is 1 (overflow)
				carry = 1'b1; // Carry
			else
				carry = 1'b0; // No carry
		end else if (a[7] == 1'b1 && b[7] == 1'b0) begin
			if ((~a[6:0] + 1) + b[6:0] >= 8'b10000000) // MSB is 1 (overflow)
				carry = 1'b1; // Carry
			else
				carry = 1'b0; // No carry
		end
		
		// Calculate the sum
		if (carry == 1'b1)
			sum = a[7:0] + b[7:0] + 1'b1; // Add carry
		else
			sum = a[7:0] + b[7:0]; // No carry
	end
	
endmodule
