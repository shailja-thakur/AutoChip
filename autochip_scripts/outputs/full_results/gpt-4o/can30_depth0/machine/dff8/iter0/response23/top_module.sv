module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initialize output to 0
	initial begin
		q = 8'h0;
	end
	
	// Register logic on rising edge of clock
	always @(posedge clk) begin
		q <= d;
	end

endmodule
