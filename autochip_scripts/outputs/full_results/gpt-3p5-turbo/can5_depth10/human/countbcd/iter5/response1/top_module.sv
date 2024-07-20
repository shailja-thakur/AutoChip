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
			ena <= (q0 == 4'b1001) && (q1 == 4'b1001) && (q2 == 4'b1001);
			if (ena[2]) begin
				if (ena[1]) begin
					if (ena[0]) begin
						q3 <= q3 + 1;
						q2 <= 4'b0000;
						q1 <= 4'b0000;
						q0 <= 4'b0000;
					end else begin
						q2 <= q2 + 1;
						q1 <= 4'b0000;
						q0 <= 4'b0000;
					end
				end else begin
					q1 <= q1 + 1;
					q0 <= 4'b0000;
				end
			end else begin
				q0 <= q0 + 1;
			end
		end
	end
	assign q = {q3, q2, q1, q0};
endmodule
