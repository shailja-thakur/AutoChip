module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output [15:0] q);

	reg [3:1] enable_next;
	reg [15:0] q_next;
	
	always @(posedge clk) begin
		if (reset)
			q <= 16'b0000;
		else begin
			q <= q_next;
			enable_next[1] <= ena[1] && q[3:0] == 4'b1001;
			enable_next[2] <= ena[2] && q[7:4] == 4'b1001;
			enable_next[3] <= ena[3] && q[11:8] == 4'b1001;
		end
	end

	always @(posedge clk) begin
		if (reset)
			q_next <= 16'b0000;
		else if (enable_next[1])
			q_next[3:0] <= 4'b0000;
		else if (enable_next[2])
			q_next[7:4] <= 4'b0000;
		else if (enable_next[3])
			q_next[11:8] <= 4'b0000;
		else
			q_next <= q + 1;
	end
	
	assign ena = q[15:13] != 3'b111;
	
endmodule
