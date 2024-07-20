module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum; // Use a 9-bit wire to capture the result including the carry out bit
	assign sum = a + b;
	assign s = sum[7:0];
	
	// Overflow occurs if the carry into the sign bit differs from the carry out of the sign bit
	assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
