module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] temp;

	assign temp = a + b;
	assign s = temp[7:0];
	assign overflow = temp[8];

endmodule
