module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Variable to hold signed sum
	reg [7:0] sum;

	// Perform the addition
	always @(a or b) begin
		// Check for overflow
		if (((a[7] == 1) & (b[7] == 1) & (sum[7] == 0)) | ((a[7] == 0) & (b[7] == 0) & (sum[7] == 1))) begin
			overflow = 1;
		end else begin
			overflow = 0;
		end

		// Calculate the sum
		sum = a + b;
	end

	// Assign the sum to the output
	assign s = sum;

endmodule
