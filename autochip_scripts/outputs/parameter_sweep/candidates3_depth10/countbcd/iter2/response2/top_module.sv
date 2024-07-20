module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q
);

	reg [3:1] q_temp;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			q_temp <= 0;
		end else begin
			if (ena[1])
				q_temp[3:0] <= q[3:0] + 1;
			if (ena[2])
				q_temp[7:4] <= q[7:4] + 1;
			if (ena[3])
				q_temp[11:8] <= q[11:8] + 1;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			q <= 0;
		end else begin
			q <= {q_temp[15:12], q_temp[11:8], q_temp[7:4], q_temp[3:0]};
		end
	end

endmodule
