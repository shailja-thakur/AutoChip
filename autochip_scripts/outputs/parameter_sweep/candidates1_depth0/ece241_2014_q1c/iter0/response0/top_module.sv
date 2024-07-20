module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Variable for the sum of a and b
	reg [7:0] sum;

	// Variable to check for overflow
	reg overflow;

	always @(*) begin
		sum = a + b;

		// Check for overflow
		if ((a[7] && b[7] && ~sum[7]) || (~a[7] && ~b[7] && sum[7])) begin
			overflow = 1;
		end else begin
			overflow = 0;
		end
	end

	assign s = sum;

endmodule
