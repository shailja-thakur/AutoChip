module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_pre;

	always @(posedge clk) begin
		in_pre <= in;
		for (integer i=0; i<8; i=i+1) begin
			anyedge[i] <= (in[i] && !in_pre[i]) ? 1'b1 : 1'b0;
		end
	end

endmodule
