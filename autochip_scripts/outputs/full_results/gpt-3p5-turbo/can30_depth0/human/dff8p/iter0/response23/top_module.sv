module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_reg;
	always @(negedge clk or posedge reset) begin
		if (reset)
			q_reg <= 8'd34;
		else
			q_reg <= d;
	end

	always @*
		q = q_reg;
endmodule
