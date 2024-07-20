module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_prev;

	always @(posedge clk or posedge reset) begin
		if (reset)
			in_prev <= 0;
		else
			in_prev <= in;
	end

	always @(posedge clk) begin
		for (int i = 0; i < 32; i = i + 1) begin
			if (in[i] && !in_prev[i])
				out[i] <= 1;
			else
				out[i] <= 0;
		end
	end
endmodule
