module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	reg [3:0] out;

	always @(sel, in) begin
		out = in[(sel+3):(sel)];
	end

endmodule
