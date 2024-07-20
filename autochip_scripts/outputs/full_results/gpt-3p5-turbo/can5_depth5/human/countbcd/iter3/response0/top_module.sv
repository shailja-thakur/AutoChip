module top_module(
	input clk,
	input reset,
	output reg [2:0] ena,
	output reg [15:0] q);

	reg [15:0] next_q;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			// Increment ones digit
			if (ena[0])
				next_q[3:0] <= q[3:0] + 1;
			else
				next_q[3:0] <= q[3:0];

			// Increment tens digit
			if (ena[1])
				next_q[7:4] <= q[7:4] + 1;
			else
				next_q[7:4] <= q[7:4];
			
			// Increment hundreds digit
			if (ena[2])
				next_q[11:8] <= q[11:8] + 1;
			else
				next_q[11:8] <= q[11:8];
			
			// Increment thousands digit
			next_q[15:12] <= q[15:12] + 1;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			ena <= 3'b0;
		else
			ena <= ena;
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else
			q <= next_q;
	end

endmodule
