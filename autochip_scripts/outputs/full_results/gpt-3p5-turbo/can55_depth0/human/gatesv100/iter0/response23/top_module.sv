module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	wire [98:0] in_left_shifted;
	wire [99:0] in_right_shifted;
	wire [98:0] out_both_temp;

	assign in_left_shifted = {in[0], in[99:1]};
	assign in_right_shifted = {in[1:99], in[0]};
	assign out_both_temp = in & in_left_shifted;

	assign out_both = out_both_temp[98:0];
	assign out_any = in | in_right_shifted;
	assign out_different = in ^ in_left_shifted;

endmodule
