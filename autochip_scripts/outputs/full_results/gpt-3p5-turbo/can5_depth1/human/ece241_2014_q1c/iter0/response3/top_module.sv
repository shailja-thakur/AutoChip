module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// intermediate variables
	reg [8:0] sum;
	reg overflow;

	always @(*) begin
		// check for overflow
		overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

		// compute sum
		sum = a + b;

		// truncate to 8 bits
		s = sum[7:0];
	end

endmodule
