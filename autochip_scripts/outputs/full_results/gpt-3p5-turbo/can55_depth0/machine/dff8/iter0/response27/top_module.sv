module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initialize output to default value
	initial begin
		q <= 8'h0;
	end

	// Store data input in the register on rising edge of clock
	always @(posedge clk) begin
		q <= d;
	end

endmodule
