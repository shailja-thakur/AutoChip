module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal signals
	reg [7:0] sum;
	wire overflow;

	// Calculate sum and overflow
	always @* begin
		sum = a + b;
		overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);
	end

	// Assign outputs
	assign s = sum;
	assign overflow = overflow;

endmodule
