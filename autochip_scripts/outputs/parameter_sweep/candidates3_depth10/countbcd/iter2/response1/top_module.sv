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
			q_temp <= 0; // Added line
		end else begin
			if (ena[1])
				q_temp[3:0] <= q[3:0] + 1;
			else
				q_temp[3:0] <= q[3:0]; // Added line

			if (ena[2])
				q_temp[7:4] <= q[7:4] + 1;
			else
				q_temp[7:4] <= q[7:4]; // Added line

			if (ena[3])
				q_temp[11:8] <= q[11:8] + 1;
			else
				q_temp[11:8] <= q[11:8]; // Added line

			q <= q_temp; // Added line
		end
	end

endmodule
