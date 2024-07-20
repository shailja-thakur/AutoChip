module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
		end else if (ena[1]) begin
			q[3:0] <= q[3:0] + 4'b0001;
		end else if (ena[2]) begin
			q[7:4] <= q[7:4] + 4'b0001;
		end else if (ena[3]) begin
			q[11:8] <= q[11:8] + 4'b0001;
		end
	end

	assign ena = q[12:10];

endmodule
