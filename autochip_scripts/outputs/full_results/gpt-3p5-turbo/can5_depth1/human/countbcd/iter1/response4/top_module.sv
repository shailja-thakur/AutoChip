module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] next_q;

	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 0;
		else begin
			if (ena[1])
				next_q[7:4] <= next_q[7:4] + 1;
			else
				next_q[7:4] <= next_q[7:4];
			
			if (ena[2])
				next_q[11:8] <= next_q[11:8] + 1;
			else
				next_q[11:8] <= next_q[11:8];
			
			if (ena[3])
				next_q[15:12] <= next_q[15:12] + 1;
			else
				next_q[15:12] <= next_q[15:12];
		end
	end

	assign q = next_q;
	assign ena = {1'b0, ena[3:1]};

endmodule
