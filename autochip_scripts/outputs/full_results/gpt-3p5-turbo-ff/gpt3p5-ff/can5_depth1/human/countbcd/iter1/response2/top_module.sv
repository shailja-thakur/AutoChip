module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] digit;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 16'b0000;
		else begin
			if (ena[1]) begin
				if (q[3:0] == 4'b1001)
					q[3:0] <= 4'b0000;
				else
					q[3:0] <= q[3:0] + 4'b0001;
			end
			if (ena[2]) begin
				if (q[7:4] == 4'b1001)
					q[7:4] <= 4'b0000;
				else
					q[7:4] <= q[7:4] + 4'b0001;
			end
			if (ena[3]) begin
				if (q[11:8] == 4'b1001)
					q[11:8] <= 4'b0000;
				else
					q[11:8] <= q[11:8] + 4'b0001;
			end
		end
	end

	always @(q[3:0])
		digit[1] = (q[3:0] > 4'b1001);

	always @(q[7:4])
		digit[2] = (q[7:4] > 4'b1001);

	always @(q[11:8])
		digit[3] = (q[11:8] > 4'b1001);

	assign ena = digit;

endmodule
