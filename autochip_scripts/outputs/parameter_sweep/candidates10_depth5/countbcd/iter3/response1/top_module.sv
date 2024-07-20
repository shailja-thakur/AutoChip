module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_reg;
	reg [15:0] q_next;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q_reg <= 16'b0000;
		else
			q_reg <= q_next;
	end

	always @* begin
		if (q_reg[3:0] == 4'b1001)
			q_next[3:0] = 4'b0000;
		else
			q_next[3:0] = q_reg[3:0] + 1;
			
		if (q_reg[7:4] == 4'b1001)
			q_next[7:4] = 4'b0000;
		else if (ena[2])
			q_next[7:4] = q_reg[7:4] + 1;
		else
			q_next[7:4] = q_reg[7:4];
			
		if (q_reg[11:8] == 4'b1001)
			q_next[11:8] = 4'b0000;
		else if (ena[3])
			q_next[11:8] = q_reg[11:8] + 1;
		else
			q_next[11:8] = q_reg[11:8];
			
		if (ena[1])
			q_next[15:12] = q_reg[15:12] + 1;
		else
			q_next[15:12] = q_reg[15:12];
	end
	
	assign ena = (q_reg[15:13] != 3'b111);
	assign q = q_reg;
	
endmodule
