module top_module (
	input [31:0] in,
	output [31:0] out
);

	reg [31:0] reversed;

	assign reversed[7:0] = in[31:24];
	assign reversed[15:8] = in[23:16];
	assign reversed[23:16] = in[15:8];
	assign reversed[31:24] = in[7:0];

	assign out = reversed;

endmodule
