module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q3;
	reg [3:0] q2;
	reg [3:0] q1;
	reg [3:0] q0;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q3 <= 4'b0;
			q2 <= 4'b0;
			q1 <= 4'b0;
			q0 <= 4'b0;
		end else if (ena[3]) begin
			if (q3 == 9)
				q3 <= 4'b0;
			else
				q3 <= q3 + 1;
		end else if (ena[2]) begin
			if (q2 == 9)
				q2 <= 4'b0;
			else
				q2 <= q2 + 1;
		end else if (ena[1]) begin
			if (q1 == 9)
				q1 <= 4'b0;
			else
				q1 <= q1 + 1;
		end

		if (ena[3] || ena[2] || ena[1]) begin
			if (q0 == 9)
				q0 <= 4'b0;
			else
				q0 <= q0 + 1;
		end
	end

	assign ena = {reset, reset, ena[2]};
	assign q = {q3, q2, q1, q0};

endmodule
