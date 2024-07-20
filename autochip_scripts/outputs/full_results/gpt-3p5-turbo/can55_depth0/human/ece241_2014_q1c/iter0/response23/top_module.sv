module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// internal signal to hold the sum of a and b
	reg [8:0] sum;

	// internal signal to detect the overflow
	reg overflow;

	// adder logic
	assign sum = a + b;
	assign s = sum[7:0];

	// overflow detection
	always @*
	begin
		if (a[7] == b[7] && sum[8] != a[7])
			overflow = 1;
		else
			overflow = 0;
	end

endmodule
