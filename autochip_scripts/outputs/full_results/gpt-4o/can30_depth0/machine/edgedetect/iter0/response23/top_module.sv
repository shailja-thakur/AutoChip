module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] d_last;

	// Always block that triggers on the rising edge of clock
	always @(posedge clk) begin
		// Calculate pedge signal
		pedge <= in & ~d_last;
		// Store current in value in d_last register for the next cycle
		d_last <= in;
	end

endmodule
