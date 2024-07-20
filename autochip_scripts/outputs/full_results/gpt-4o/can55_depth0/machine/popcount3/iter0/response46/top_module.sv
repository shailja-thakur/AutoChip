module top (
	input [2:0] in,
	output [1:0] out
);

	assign out = in[2:0] + in[1:0] + in[0:0];

endmodule
