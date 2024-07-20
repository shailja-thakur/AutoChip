module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
	always @(*) begin
		min = a; // Start by assuming 'a' is the minimum
		if (b < min) min = b; // Compare 'b' with current min
		if (c < min) min = c; // Compare 'c' with current min
		if (d < min) min = d; // Compare 'd' with current min
	end
endmodule
