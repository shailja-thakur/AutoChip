module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] q_L;
	reg [3:0] q_M;
	reg [3:0] q_H;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_L <= 4'b0;
			q_M <= 4'b0;
			q_H <= 4'b0;
		end else begin
			if (ena[0])
				q_L <= q_L + 1;

			if (ena[1])
				q_M <= q_M + 1;

			if (ena[2])
				q_H <= q_H + 1;
		end
	end

	assign q = {q_H, q_M, q_L};
endmodule
