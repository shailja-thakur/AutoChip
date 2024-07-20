module top_module (
	input clk,
	input in,
	output reg out
);

	// Initialize output signal to 0
	initial begin
		out = 0;
	end
	
	// Toggle flip-flop operation
	always @(posedge clk) begin
		out <= out ^ in;
	end

endmodule
