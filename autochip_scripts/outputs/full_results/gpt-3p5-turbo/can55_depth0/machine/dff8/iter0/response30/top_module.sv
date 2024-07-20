module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Initialize the output to a default value
	initial begin
		q <= 8'b0;
	end

	// Register logic
	always @(posedge clk) begin
		q <= d;
	end

endmodule
