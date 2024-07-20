module top_module(
	input clk,
	input d,
	output reg q);

	// Initialize q to an unknown value
	initial begin
		q = 1'hx;
	end

	// Synchronize d with clk
	always @(posedge clk) begin
		q <= d;
	end

endmodule
