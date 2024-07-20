module top_module (
	input clk,
	input in,
	output reg out
);

	// Initialize out to 0
	initial out = 0;

	// Toggle flip-flop on the positive edge of the clock
	always @(posedge clk) begin
		out <= out ^ in;
	end

endmodule
