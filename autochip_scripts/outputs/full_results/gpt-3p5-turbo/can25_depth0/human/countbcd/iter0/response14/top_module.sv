module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk) begin
		if (reset) begin
			q <= 16'b0000;
		end else begin
			if (ena[1]) begin
				q[7:4] <= q[7:4] + 1;
				if (q[7:4] == 10) begin
					q[7:4] <= 0;
					if (ena[2]) begin
						q[11:8] <= q[11:8] + 1;
						if (q[11:8] == 10) begin
							q[11:8] <= 0;
							if (ena[3]) begin
								q[15:12] <= q[15:12] + 1;
								if (q[15:12] == 10) begin
									q[15:12] <= 0;
								end
							end
						end
					end
				end
			end
			q[3:0] <= q[3:0] + 1;
			if (q[3:0] == 10) begin
				q[3:0] <= 0;
			end
		end
	end

endmodule
