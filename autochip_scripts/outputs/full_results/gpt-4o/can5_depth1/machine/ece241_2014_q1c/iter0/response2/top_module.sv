module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

	// Create a wire to hold the sum of 'a' and 'b'
	wire [8:0] sum;
	assign sum = a + b;

	// Assign the 8-bit output 's' to the 8 least significant bits of 'sum'
	assign s = sum[7:0];

	// Assign the overflow output
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
