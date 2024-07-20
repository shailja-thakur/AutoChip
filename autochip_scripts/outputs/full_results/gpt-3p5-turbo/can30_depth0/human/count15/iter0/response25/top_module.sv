module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Define signals
	reg [3:0] next_q;

	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 4'b0000;
		else if (q == 4'b1111)
			next_q <= 4'b0000;
		else
			next_q <= q + 1;
	end

	assign q = next_q;

endmodule
