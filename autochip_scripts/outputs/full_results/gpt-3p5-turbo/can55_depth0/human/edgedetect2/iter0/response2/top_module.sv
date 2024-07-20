module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_delay;

	always @(posedge clk) begin
		in_delay <= in;
		anyedge <= 0;
		for (int i=0; i<8; i=i+1) begin
			if (in_delay[i] == 1 && in[i] == 0)
				anyedge[i] <= 1;
		end
	end
endmodule
