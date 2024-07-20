module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
		end else begin
			q <= q_next;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			q_next <= 16'b0000;
		end else begin
			q_next <= q;

			if (ena[1])
				q_next[3:0] <= q[3:0] + 4'b0001;
      
			if (ena[2])
				q_next[7:4] <= q[7:4] + 4'b0001;

			if (ena[3])
				q_next[11:8] <= q[11:8] + 4'b0001;
		end
	end

	assign ena = q[14:12];

endmodule
