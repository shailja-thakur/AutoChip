module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output reg overflow
);

	// wire declaration for intermediate signals
	wire signed_sum;

	// sign extension of input numbers
	wire [15:0] a_ext = {{8{a[7]}}, a};
	wire [15:0] b_ext = {{8{b[7]}}, b};

	// 2's complement addition
	assign signed_sum = a_ext + b_ext;

	// output signals
	always @* begin
		s = signed_sum[7:0];
		overflow = (signed_sum[8] != signed_sum[7]);
	end

endmodule
