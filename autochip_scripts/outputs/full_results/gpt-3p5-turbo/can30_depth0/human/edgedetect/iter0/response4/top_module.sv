module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	always @(posedge clk) begin
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] & !in[i-1])
				pedge[i] <= 1; // set the output bit when positive edge occurs
			else
				pedge[i] <= 0; // reset the output bit
		end
	end

endmodule
