module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge
);

	reg [7:0] prev_in;

	always @(posedge clk) begin
		for (int i = 0; i < 8; i = i + 1) begin
			if (in[i] && !prev_in[i])
				anyedge[i] <= 1;
			else
				anyedge[i] <= 0;
		end
		prev_in <= in;
	end
endmodule
