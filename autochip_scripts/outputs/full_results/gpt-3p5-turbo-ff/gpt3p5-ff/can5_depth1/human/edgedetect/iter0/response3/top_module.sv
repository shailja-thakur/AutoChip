module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	always @(posedge clk) begin
		pedge <= 0;
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1 && in[i] != $past(in[i]))
				pedge[i] <= 1;
		end
	end

endmodule
