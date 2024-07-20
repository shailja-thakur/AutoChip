module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output reg overflow
);

	// Declare internal signals
	reg signed [8:0] sum; // Sum of a and b (including carry bit)
	reg signed [8:0] a_signed; // Sign-extended a
	reg signed [8:0] b_signed; // Sign-extended b
	
	// Assign outputs
	assign s = sum[7:0]; // Output the lower 8 bits of the sum
	
	// Perform the sign extension
	always @(*) begin
		if (a[7] == 1'b1) // If MSB of a is 1 (negative number)
			a_signed = {8'b11111111, a}; // Sign-extend a
		else
			a_signed = {8'b00000000, a}; // Sign-extend a with 0s
		
		if (b[7] == 1'b1) // If MSB of b is 1 (negative number)
			b_signed = {8'b11111111, b}; // Sign-extend b
		else
			b_signed = {8'b00000000, b}; // Sign-extend b with 0s
	end
	
	// Perform the addition operation
	always @(*) begin // Use combinational logic
		sum = a_signed + b_signed; // Add a and b
		
		// Check for overflow
		overflow = (sum[8] != sum[7]); // Overflow occurs when MSB and second MSB are not equal
	end
	
endmodule
