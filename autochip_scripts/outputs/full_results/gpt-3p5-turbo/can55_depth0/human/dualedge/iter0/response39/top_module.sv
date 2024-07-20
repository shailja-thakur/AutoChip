module top_module(
	input clk,
	input d,
	output reg q);

	// Internal signals
	reg q_delayed;

	// Process for capturing input on positive edge of clock
	always @(posedge clk) begin
		q_delayed <= q;
		q <= d;
	end

	// Process for capturing input on negative edge of clock
	always @(negedge clk) begin
		q_delayed <= q;
		q <= d;
	end

endmodule
