module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:8] c,
	input [7:0] d,
	output reg [7:0] min
);

always @(*) begin
	// Initial assumption: 'a' is the minimum
	min = a;

	// Compare with 'b', if 'b' is smaller, update 'min'
	if (b < min) min = b;

	// Compare with 'c', if 'c' is smaller, update 'min'
	if (c < min) min = c;

	// Compare with 'd', if 'd' is smaller, update 'min'
	if (d < min) min = d;
end

endmodule
