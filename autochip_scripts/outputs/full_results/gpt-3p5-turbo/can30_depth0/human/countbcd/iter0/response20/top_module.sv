module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			ena <= 0;
		end else begin
			if (ena[1]) begin
				if (q[3:0] == 9)
					q[3:0] <= 0;
				else
					q[3:0] <= q[3:0] + 1;
			end
			if (ena[2]) begin
				if (q[7:4] == 9)
					q[7:4] <= 0;
				else
					q[7:4] <= q[7:4] + 1;
			end
			if (ena[3]) begin
				if (q[11:8] == 9)
					q[11:8] <= 0;
				else
					q[11:8] <= q[11:8] + 1;
			end
		end
	end
endmodule
