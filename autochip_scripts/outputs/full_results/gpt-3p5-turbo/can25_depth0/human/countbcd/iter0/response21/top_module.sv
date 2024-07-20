module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [3:0] q0;
	reg [3:0] q1;
	reg [3:0] q2;
	reg [3:0] q3;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q0 <= 4'd0;
			q1 <= 4'd0;
			q2 <= 4'd0;
			q3 <= 4'd0;
		end else if (ena[0]) begin
			q0 <= q0 + 1;
			if (q0 >= 10) begin
				q0 <= 4'd0;
				q1 <= q1 + 1;
				if (q1 >= 10) begin
					q1 <= 4'd0;
					q2 <= q2 + 1;
					if (q2 >= 10) begin
						q2 <= 4'd0;
						q3 <= q3 + 1;
						if (q3 >= 10) begin
							q3 <= 4'd0;
						end
					end
				end
			end
		end else begin
			q0 <= q0;
		end
	end
	
	assign q = {q3, q2, q1, q0};
endmodule
