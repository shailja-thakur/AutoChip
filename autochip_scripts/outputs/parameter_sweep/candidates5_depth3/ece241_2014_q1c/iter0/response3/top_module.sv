module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire for intermediate sum result
	wire [8:0] sum;
	reg [7:0] s;
	reg overflow;

	// Assign the intermediate sum
	assign sum = a + b;

	// Assign the output sum
	assign s = sum[7:0];

	// Check for overflow
	always @* begin
		if ((a[7] == 1 && b[7] == 1 && sum[8] == 0) || (a[7] == 0 && b[7] == 0 && sum[8] == 1))
			overflow = 1;
		else
			overflow = 0;
	end

endmodule
