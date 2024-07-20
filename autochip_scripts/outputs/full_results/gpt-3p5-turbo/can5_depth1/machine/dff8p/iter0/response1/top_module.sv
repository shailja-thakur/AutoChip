module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	always @(negedge clk) begin
		if (reset) begin
			q <= 8'h34; // Set q to 8'h34 if reset is asserted
		end else begin
			q <= d; // Set q to d if reset is not asserted
		end
	end

endmodule
