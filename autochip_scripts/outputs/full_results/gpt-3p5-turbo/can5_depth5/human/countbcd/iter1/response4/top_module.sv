module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			// Increment ones digit
			if (ena[1])
				q[3:0] <= q[3:0] + 1;

			// Increment tens digit
			if (ena[2])
				q[7:4] <= q[7:4] + 1;
			
			// Increment hundreds digit
			if (ena[3])
				q[11:8] <= q[11:8] + 1;
			
			// Increment thousands digit
			if (q[15:12] == 9 && q[11:8] == 9 && q[7:4] == 9 && q[3:0] == 9)
				q <= 0;
			else if (q[3:0] == 9)
				q[3:0] <= 0;
			else if (q[7:4] == 9)
				q[7:4] <= 0;
			else if (q[11:8] == 9)
				q[11:8] <= 0;
			else
				q[15:12] <= q[15:12] + 1;
		end
	end
endmodule
