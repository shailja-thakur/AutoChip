module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Wire declaration
	wire [3:0] in_ext;
	wire [2:0] out_both_ext;
	wire [3:0] out_any_ext;
	wire [3:0] out_different_ext;

	// Input extension
	assign in_ext = {in[3], in};

	// Logic for out_both
	assign out_both_ext[2] = in_ext[2] & in_ext[3];
	assign out_both_ext[1] = in_ext[1] & in_ext[2];
	assign out_both_ext[0] = in_ext[0] & in_ext[3];

	// Logic for out_any
	assign out_any_ext[3] = in_ext[2] | in_ext[1];
	assign out_any_ext[2] = in_ext[1] | in_ext[0];
	assign out_any_ext[1] = in_ext[0] | in_ext[3];

	// Logic for out_different
	assign out_different_ext[3] = (in_ext[2] != in_ext[3]) ? 1 : 0;
	assign out_different_ext[2] = (in_ext[1] != in_ext[2]) ? 1 : 0;
	assign out_different_ext[1] = (in_ext[0] != in_ext[1]) ? 1 : 0;
	assign out_different_ext[0] = (in_ext[3] != in_ext[0]) ? 1 : 0;

	// Output assignment
	assign out_both = out_both_ext[2:0];
	assign out_any = out_any_ext[3:1];
	assign out_different = out_different_ext[3:0];

endmodule
