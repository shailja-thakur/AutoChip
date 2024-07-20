module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Define internal signals
	reg [3:1] cnt;
	reg [3:1] next_cnt;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cnt <= 3'b0;
			q <= 16'b0;
		end else begin
			cnt <= next_cnt;
			q <= {q[11:0], cnt};
		end
	end

	always @(clk) begin
		if (ena[1])
			next_cnt[1] <= cnt[1] + 1'b1;
		else
			next_cnt[1] <= cnt[1];

		if (ena[2])
			next_cnt[2] <= cnt[2] + 1'b1;
		else
			next_cnt[2] <= cnt[2];

		if (ena[3])
			next_cnt[3] <= cnt[3] + 1'b1;
		else
			next_cnt[3] <= cnt[3];
	end

	assign ena = cnt;

endmodule
