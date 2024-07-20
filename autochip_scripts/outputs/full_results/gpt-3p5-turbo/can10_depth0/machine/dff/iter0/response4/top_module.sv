module top_module(
	input wire clk,
	input wire d,
	output reg q);

	// Initialize register signal q
	initial begin
		q = 1'hx;
	end
	
	// Register update on rising edge of clock signal
	always @(posedge clk) begin
		q <= d;
	end

endmodule
