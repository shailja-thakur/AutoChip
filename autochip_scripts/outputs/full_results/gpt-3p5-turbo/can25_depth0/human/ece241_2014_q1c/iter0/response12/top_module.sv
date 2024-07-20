module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire to hold the result of the addition
	wire [8:0] sum;

	// Intermediate wire to hold overflow status
	wire signed_overflow;
	
	// Adder circuit to calculate sum
	adder_8bit adder(.a(a), .b(b), .sum(sum));
	
	// Calculates overflow status
	assign signed_overflow = sum[8] ^ sum[7];

	// Output the result
	assign s = sum[7:0];
	assign overflow = signed_overflow;
 
endmodule
module adder_8bit(
	input [7:0] a,
	input [7:0] b,
	output [8:0] sum
);
 
	// Internal wire for carry bit
	wire carry;
  
	// Generate the sum
	assign sum = a + b + carry;

	// Calculate the carry
	assign carry = sum[8] | ((a[7] ^ b[7]) & sum[7]);

endmodule
