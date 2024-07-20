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
			if (q0 == 4'b1001) begin
				q0 <= 4'b0000;
				if (q1 == 4'b1001) begin
					q1 <= 4'b0000;
					if (q2 == 4'b1001) begin
						q2 <= 4'b0000;
						if (q3 == 4'b1001)
							q3 <= 4'b0000;
						else
							q3 <= q3 + 1;
					end else
						q2 <= q2 + 1;
				end else
					q1 <= q1 + 1;
			end else
				q0 <= q0 + 1;
			
			if (q0 == 4'b1001)
				ena[0] <= 1;
			else
				ena[0] <= 0;
			
			if (q1 == 4'b1001)
				ena[1] <= 1;
			else
				ena[1] <= 0;
			
			if (q2 == 4'b1001)
				ena[2] <= 1;
			else
				ena[2] <= 0;
		end
		q = {q3, q2, q1, q0};
	end
endmodule
