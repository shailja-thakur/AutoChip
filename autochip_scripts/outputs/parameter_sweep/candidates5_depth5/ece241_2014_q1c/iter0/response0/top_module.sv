module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal signals
	reg [8:0] temp;

	// Assignments
	assign overflow = a[7] & b[7] & !s[7] | !a[7] & !b[7] & s[7];
	assign temp = {1'b0, a} + {1'b0, b};
	assign s = temp[7:0];

endmodule
