module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			ena <= 3'b0;
		end else begin
			q <= q_next;
			ena <= q[11:9];
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			q_next <= 16'b0000;
		end else begin
			if (q[3:0] == 4'b1001) begin
				q_next[3:0] <= 4'b0000;
				if (q[7:4] == 4'b1001) begin
					q_next[7:4] <= 4'b0000;
					if (q[11:8] == 4'b1001) begin
						q_next[11:8] <= 4'b0000;
						if (q[15:12] == 4'b1001)
							q_next[15:12] <= 4'b0000;
						else
							q_next[15:12] <= q[15:12] + 1;
					end else
						q_next[11:8] <= q[11:8] + 1;
				end else
					q_next[7:4] <= q[7:4] + 1;
			end else
				q_next[3:0] <= q[3:0] + 1;
		end
	end
	
endmodule
