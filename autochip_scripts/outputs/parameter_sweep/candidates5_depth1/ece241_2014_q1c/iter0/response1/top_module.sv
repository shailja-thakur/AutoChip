module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal signals
	reg [7:0] sum;
	reg sign_a, sign_b, sign_sum;
	
	always @(*) begin
		// Determine sign of a
		sign_a = a[7];
		
		// Determine sign of b
		sign_b = b[7];
		
		// Perform addition
		sum = a + b;
		
		// Determine sign of sum
		sign_sum = sum[7];
		
		// Determine overflow
		if (sign_a == sign_b && sign_a != sign_sum)
			overflow = 1;
		else
			overflow = 0;
	end
	
	assign s = sum;

endmodule
