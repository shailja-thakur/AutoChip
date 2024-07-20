module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	always @(posedge clk)
	begin
		pedge <= pedge;
		for (int i = 0; i < 8; i = i + 1) 
		begin
			if (in[i] == 1'b1 && pedge[i] == 1'b0)
				pedge[i] <= 1'b1;
			else
				pedge[i] <= 1'b0;
		end
	end
endmodule
