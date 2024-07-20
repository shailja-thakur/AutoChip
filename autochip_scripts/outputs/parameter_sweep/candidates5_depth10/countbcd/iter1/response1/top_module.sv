module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ena <= 0;
			q <= 0;
		end else begin
			if (ena[1])
				ena[1] <= 0;
			else
				ena[1] <= 1;

			if (ena[2])
				ena[2] <= 0;
			else
				ena[2] <= ena[1] ? 1 : 0;

			if (ena[3])
				ena[3] <= 0;
			else
				ena[3] <= ena[2] ? 1 : 0;

			if (ena[1])
				q[3:0] <= q[3:0] + 1;

			if (ena[2])
				q[7:4] <= q[7:4] + 1;

			if (ena[3])
				q[11:8] <= q[11:8] + 1;

			q[15:12] <= q[15:12] + 1;
		end
	end

endmodule
