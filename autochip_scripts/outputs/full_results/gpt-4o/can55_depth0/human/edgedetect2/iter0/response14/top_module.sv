module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in;
	integer i;

	always @(posedge clk) begin
		for (i = 0; i < 8; i = i + 1) begin
			if (in[i] != prev_in[i]) begin
				anyedge[i] <= (in[i] == 1'b1);
			end
		end
		prev_in <= in;
	end

endmodule
