module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum; // 9-bit wire to store the sum with carry bit

	assign sum = a + b; // Perform the addition

	assign s = sum[7:0]; // The 8-bit result

	// Check the overflow condition: if the sign bit of a and b are the same, but different from the sign bit of the result s
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
