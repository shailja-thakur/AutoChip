module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end
		else begin
			q <= q_next;
		end
	end

	assign q_next[3:0] = q[3:0] + 1;
	assign q_next[7:4] = (ena[1] == 1'b1) ? q[7:4] + 1 : q[7:4];
	assign q_next[11:8] = (ena[2] == 1'b1) ? q[11:8] + 1 : q[11:8];
	assign q_next[15:12] = (ena[3] == 1'b1) ? q[15:12] + 1 : q[15:12];

endmodule
