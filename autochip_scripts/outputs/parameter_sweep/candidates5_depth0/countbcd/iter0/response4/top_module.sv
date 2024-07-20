module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [15:0] q_next;
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else
			q <= q_next;
	end

	always @(posedge clk) begin
        if (reset)
			q_next <= 0;
		else if (ena[1])
			q_next <= q + 16;
		else if (ena[2])
			q_next <= q + 256;
		else if (ena[3])
			q_next <= q + 4096;
	end
endmodule
