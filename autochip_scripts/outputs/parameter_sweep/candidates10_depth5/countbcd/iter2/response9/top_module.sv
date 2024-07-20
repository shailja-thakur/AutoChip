module top_module(
	input clk,
	input reset,
	output reg[3:1] ena,
	output reg[15:0] q);
  
	reg [15:0] q_reg;
	
	always @(posedge clk) begin
		if (reset)
			q_reg <= 16'b0000;
		else if (ena != 3'b111)
			q_reg <= q_reg + 1;
	end
	
	always @* begin
		q = q_reg;
	end
	
	assign ena = q[15:13] != 3'b111;
  
endmodule
