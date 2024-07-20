module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [15:0] next_q;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 16'b0000;
		else if (ena[1] && q[3:0] == 4'b1001)
			next_q[3:0] <= 4'b0000;
		else if (ena[2] && q[7:4] == 4'b1001)
			next_q[7:4] <= 4'b0000;
		else if (ena[3] && q[11:8] == 4'b1001)
			next_q[11:8] <= 4'b0000;
		else
			next_q <= q + 1;
	end

	assign ena = q[15:13] != 3'b111; 
	
	always @(posedge clk) begin
		if (reset)
			q <= next_q;
		else
			q <= next_q;
	end 
	
endmodule
