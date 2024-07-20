module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	wire [7:0] sum;
	assign s = sum[7:0];
	
	// Correction starts here
	assign overflow = ((a[7] & !b[7] & !sum[7]) | (!a[7] & b[7] & sum[7]));
	// Correction ends here

	// Adder logic
	assign sum = a + b;

endmodule
