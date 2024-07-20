module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Wire declarations
	wire out_both_0, out_both_1, out_both_2;
	wire out_any_1, out_any_2, out_any_3;
	wire out_different_0, out_different_1, out_different_2, out_different_3;

	// Logic for out_both
	assign out_both_0 = in[0] & in[3];
	assign out_both_1 = in[1] & in[0];
	assign out_both_2 = in[2] & in[1];

	// Logic for out_any
	assign out_any_1 = in[1] | in[0];
	assign out_any_2 = in[2] | in[1];
	assign out_any_3 = in[3] | in[2];

	// Logic for out_different
	assign out_different_0 = in[0] ^ in[3];
	assign out_different_1 = in[1] ^ in[0];
	assign out_different_2 = in[2] ^ in[1];
	assign out_different_3 = in[3] ^ in[2];

	// Output assignments
	assign out_both = {out_both_2, out_both_1, out_both_0};
	assign out_any = {out_any_3, out_any_2, out_any_1};
	assign out_different = {out_different_3, out_different_2, out_different_1, out_different_0};

endmodule
