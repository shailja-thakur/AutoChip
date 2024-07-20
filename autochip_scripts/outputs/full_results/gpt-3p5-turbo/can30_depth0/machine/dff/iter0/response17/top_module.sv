module top_module(
	input clk,
	input d,
	output reg q);

	// Initialize register q to 1'hx
	initial begin
		q = 1'hx;
	end

	// Synchronize data signal d with rising edge of clock signal
	always @(posedge clk) begin
		q <= d;
	end

endmodule
