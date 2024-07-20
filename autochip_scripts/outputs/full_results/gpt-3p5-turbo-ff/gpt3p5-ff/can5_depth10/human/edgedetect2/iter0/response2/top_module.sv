module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	always @(posedge clk) begin
		for (int i=0; i<8; i=i+1) begin
			if (in[i] && !in_prev[i])
				anyedge[i] <= 1'b1;
			else
				anyedge[i] <= 1'b0;
		end
		in_prev <= in;
	end
endmodule
