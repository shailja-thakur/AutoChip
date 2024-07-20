module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q_next <= 16'b0000;
		else if (ena[1])
			q_next <= q + 4'b0001;
		else if (ena[2])
			q_next <= q + 4'b0010;
		else if (ena[3])
			q_next <= q + 4'b0100;
		else
			q_next <= q;
	end

	always @(posedge clk) begin
		if (reset)
			q <= 16'b0000;
		else
			q <= q_next;
	end

endmodule
