module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare intermediate wire variables
	wire [7:0] out_7_0;
	wire [15:8] out_15_8;
	wire [23:16] out_23_16;
	wire [31:24] out_31_24;

	// Assign output bits
	assign out_7_0 = in[7:0];
	assign out_15_8 = in[15:8];
	assign out_23_16 = in[23:16];
	assign out_31_24 = in[31:24];

	// Assign output
	assign out = {out_31_24, out_23_16, out_15_8, out_7_0};

endmodule
