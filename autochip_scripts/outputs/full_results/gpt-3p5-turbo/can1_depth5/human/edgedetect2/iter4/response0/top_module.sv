module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in = 8'b0;
	reg [7:0] current_in = 8'b0;

	always @(posedge clk) begin
		prev_in <= current_in;
		current_in <= in;
	end

	always @* begin
		for (int i = 0; i < 8; i=i+1) begin
			if (current_in[i] && !prev_in[i])
				anyedge[i] <= 1'b1;
			else
				anyedge[i] <= 1'b0;
		end
	end

endmodule
