module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q0;
	reg [3:0] q1;
	reg [3:0] q2;
	reg [3:0] q3;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q0 <= 4'b0000;
			q1 <= 4'b0000;
			q2 <= 4'b0000;
			q3 <= 4'b0000;
			ena <= 3'b0;
		end else begin
			if (ena[1]) begin
				if (q1 == 4'b1001)
					q1 <= 4'b0000;
				else
					q1 <= q1 + 1;
			end
			if (ena[2]) begin
				if (q2 == 4'b1001)
					q2 <= 4'b0000;
				else
					q2 <= q2 + 1;
			end
			if (ena[3]) begin
				if (q3 == 4'b1001)
					q3 <= 4'b0000;
				else
					q3 <= q3 + 1;
			end
			q0 <= q0 + ena[1];
		end
		q = {q3, q2, q1, q0};
	end
endmodule
