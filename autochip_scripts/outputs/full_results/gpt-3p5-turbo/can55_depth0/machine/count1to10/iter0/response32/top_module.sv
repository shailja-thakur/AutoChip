module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	reg [3:0] q_next;

	always @(posedge clk) begin
		if (reset)
			q_next <= 4'b0001;
		else if (q == 4'b1010)
			q_next <= 4'b0001;
		else
			q_next <= q + 1;
	end

	always @(posedge clk) begin
		if (reset)
			q <= 4'b0001;
		else
			q <= q_next;
	end

endmodule
