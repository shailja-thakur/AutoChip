module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @* begin
	// Initialize min with the first input
	min = a;

	// Compare with the second input
	if (b < min)
		min = b;

	// Compare with the third input
	if (c < min)
		min = c;

	// Compare with the fourth input
	if (d < min)
		min = d;
end

endmodule
