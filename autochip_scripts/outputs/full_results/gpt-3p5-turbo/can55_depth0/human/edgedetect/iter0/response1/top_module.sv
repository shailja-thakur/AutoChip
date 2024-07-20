module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] in_prev;

	always @(posedge clk) begin
		in_prev <= in;
		
		for (integer i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1 && in_prev[i] == 0)
				pedge[i] <= 1;
			else
				pedge[i] <= 0;
		end
	end
	
endmodule
