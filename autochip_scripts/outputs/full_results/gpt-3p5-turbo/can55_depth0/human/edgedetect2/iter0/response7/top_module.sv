module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	always @(posedge clk) begin
		anyedge <= 0;
		for (int i = 0; i < 8; i = i + 1) begin
			if (in[i] && !in_prev[i])
				anyedge[i] <= 1;
			in_prev[i] <= in[i];
		end
	end

	reg [7:0] in_prev;
	
endmodule
