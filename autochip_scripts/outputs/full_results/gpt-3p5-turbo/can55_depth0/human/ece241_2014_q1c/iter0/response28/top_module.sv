module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Register to store the sum of a and b
	reg [8:0] sum;
	
	// Add a and b and store the result in sum
	always @(a, b) begin
		sum = a + b;
	end
	
	// Check for overflow
	assign overflow = (sum[8] != sum[7]);
	
	// Output the result
	assign s = sum[7:0];
	
endmodule
