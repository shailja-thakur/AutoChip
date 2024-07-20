module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	// Internal Signal to hold intermediate addition result
	reg [8:0] sum;

	always @(a or b) begin
		// Perform addition
		sum = a + b;

		// Check for overflow
		if (sum[8] == 1'b1 || sum[8] == 1'b0)
			overflow = 1'b1;
		else
			overflow = 1'b0;

		// Assign sum to output s[7:0]
		if (overflow)
			s = 8'b0;
		else
			s = sum[7:0];
	end

endmodule
