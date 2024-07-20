module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Always block triggered on the negative edge of clk
	always @(negedge clk) begin
		if (reset) begin
			q <= 8'h34;  // If reset is asserted, set q to 8'h34
		end else begin
			q <= d;     // Otherwise, set q to the value of d
		end
	end
endmodule
