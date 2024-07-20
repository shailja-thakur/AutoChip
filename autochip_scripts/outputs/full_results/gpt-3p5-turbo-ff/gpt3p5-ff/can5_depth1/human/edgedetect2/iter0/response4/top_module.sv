module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	always @(posedge clk) begin
		anyedge <= 0;
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1 && in[i] != in[i+1]) begin
				anyedge[i] <= 1;
			end
		end
	end
	
endmodule
