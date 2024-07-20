module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal signals
	reg [7:0] sum;
	reg overflow;

	// Adder logic
	always @(*) begin
		sum = a + b;
		// Check for overflow
		if ((a[7] && b[7] && !sum[7]) || (!a[7] && !b[7] && sum[7])) begin
			overflow = 1;
		end else begin
			overflow = 0;
		end
	end

	// Assign outputs
	assign s = sum;

endmodule
