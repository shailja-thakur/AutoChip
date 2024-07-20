module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// On the positive edge of the clock, update each flip-flop
	always @(posedge clk) begin
		q <= d;
	end

endmodule
