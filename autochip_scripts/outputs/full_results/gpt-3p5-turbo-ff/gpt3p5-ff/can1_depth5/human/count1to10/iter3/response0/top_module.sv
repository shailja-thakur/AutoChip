module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	reg [3:0] q_reg;

	always @(posedge clk) begin
		if (reset)
			q_reg <= 4'b0001;
		else if (q_reg == 4'b1010)
			q_reg <= 4'b0000;
		else
			q_reg <= q_reg + 1;
	end
	
	always @(posedge clk) begin
		if (reset)
			q <= q_reg;
		else
			q <= q;
	end
	
endmodule
