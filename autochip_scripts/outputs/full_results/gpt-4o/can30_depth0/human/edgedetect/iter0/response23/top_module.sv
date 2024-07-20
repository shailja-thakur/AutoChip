module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	// Register to store the previous state of the input
	reg [7:0] prev_in;

	always @(posedge clk) begin
		// Detect positive edge for each bit
		pedge <= (~prev_in & in);
		// Update previous input state
		prev_in <= in;
	end

endmodule
