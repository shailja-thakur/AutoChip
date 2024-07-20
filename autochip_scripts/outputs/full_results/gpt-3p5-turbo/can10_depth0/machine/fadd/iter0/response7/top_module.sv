module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Intermediate signal for sum of a, b, and cin
	wire temp_sum;
	
	// Assign statement to calculate sum
	assign temp_sum = a + b + cin;
	
	// Calculate carry-out bit
	assign cout = (temp_sum >= 2) ? 1'b1 : 1'b0;
	
	// Calculate final output sum
	assign sum = temp_sum % 2;
	
endmodule
