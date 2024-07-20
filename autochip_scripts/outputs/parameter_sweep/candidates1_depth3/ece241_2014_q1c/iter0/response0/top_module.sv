module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// wire declaration for intermediate signals
	wire [8:0] signed_sum;
	wire overflow;

	// sign extension of input numbers
	wire [15:0] a_ext = {{8{a[7]}}, a};
	wire [15:0] b_ext = {{8{b[7]}}, b};

	// 2's complement addition
	assign signed_sum = a_ext + b_ext;

	// output signals
	assign s = signed_sum[7:0];
	assign overflow = (signed_sum[8] != signed_sum[7]);

endmodule
