module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] in_previous;

	always @(posedge clk) begin
		in_previous <= in;
		pedge <= 0;

		for (integer i = 0; i < 8; i = i + 1) begin
			if (in_previous[i] == 0 && in[i] == 1)
				pedge[i] <= 1;
		end
	end

endmodule
