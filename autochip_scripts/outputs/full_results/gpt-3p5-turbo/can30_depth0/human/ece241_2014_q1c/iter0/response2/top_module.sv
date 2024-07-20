module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// internal wire to hold the intermediate sum
	wire [8:0] sum;

	// internal wire to check if overflow occurred
	wire overflow;

	// internal wire to hold the sign of a and b
	wire sign_a, sign_b;

	// assign the sign bit of a and b
	assign sign_a = a[7];
	assign sign_b = b[7];

	// assign the sum of a and b
	assign sum = {1'b0, a} + {1'b0, b};

	// assign the sum output
	assign s = sum[7:0];

	// assign overflow when signs of a and b are the same but different from the sign of sum
	assign overflow = (sign_a == sign_b) && (sign_a != sum[8]);

endmodule
