module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q
);

	reg [3:0] q_temp;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			q_temp <= 0;
		end else begin
			if (ena[1])
				q_temp[3:0] <= q_temp[3:0] + 1;
			if (ena[2]) begin
				if (q_temp[7:4] == 9)
					q_temp[7:4] <= 0;
				else
					q_temp[7:4] <= q_temp[7:4] + 1;
			end
			if (ena[3]) begin
				if (q_temp[11:8] == 9)
					q_temp[11:8] <= 0;
				else
					q_temp[11:8] <= q_temp[11:8] + 1;
			end
		end
	end

	always @(posedge clk) begin
		if (reset)
			q <= 0;
		else
			q <= {q[11:0], q_temp[3:0]};
	end

endmodule
