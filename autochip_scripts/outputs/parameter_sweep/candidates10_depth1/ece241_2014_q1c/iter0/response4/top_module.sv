module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

	// Internal wire to store the sum of a and b
	wire [8:0] sum;

	// Internal wire to store the sign bit of a
	wire sign_a;

	// Internal wire to store the sign bit of b
	wire sign_b;

	// Internal wire to store the sign bit of the sum
	wire sign_sum;

	// Calculate the sign bit of a
	assign sign_a = a[7];

	// Calculate the sign bit of b
	assign sign_b = b[7];

	// Calculate the sign bit of the sum
	assign sign_sum = sum[8];

	// Calculate the sum of a and b
	assign sum = {1'b0, a} + {1'b0, b};

	// Calculate the overflow
	assign overflow = (sign_a == sign_b) && (sign_sum != sign_a);

	// Assign the 8-bit sum to the output s
	assign s = sum[7:0];
	
endmodule
