module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [3:0] out_reg;

	always @(*)
	begin
		out_reg = in[4*sel +: 4];
	end

	assign out = out_reg;

endmodule
