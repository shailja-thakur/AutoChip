module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	wire [255:0] in_slice [0:3];
	assign in_slice[0] = in[3:0];
	assign in_slice[1] = in[7:4];
	assign in_slice[2] = in[11:8];
	assign in_slice[3] = in[15:12];

	assign out = in_slice[sel];

endmodule
