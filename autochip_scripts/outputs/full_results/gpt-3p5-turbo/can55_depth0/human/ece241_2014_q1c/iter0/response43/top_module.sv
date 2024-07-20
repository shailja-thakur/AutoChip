module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] signed_sum;
	reg signed_overflow;

	always @(*) begin
		signed_sum = a + b;
		if (signed_sum > 127 || signed_sum < -128) begin
			signed_overflow = 1;
		end else begin
			signed_overflow = 0;
		end
	end

	assign s = signed_sum[7:0];
	assign overflow = signed_overflow;

endmodule
