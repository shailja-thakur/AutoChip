module top_module(
	input clk,
	input d,
	output reg q);

	// Signal to store intermediate value
	reg int_q;

	// Positive edge triggered flip-flop
	always @(posedge clk) begin
		int_q <= d;
	end

	// Negative edge triggered flip-flop
	always @(negedge clk) begin
		q <= int_q;
	end

endmodule
