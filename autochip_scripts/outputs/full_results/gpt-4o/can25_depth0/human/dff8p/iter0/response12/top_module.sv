module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Reset value 0x34 is 00110100 in binary.
	always @(negedge clk) begin
		if (reset) begin
			q <= 8'h34; // Assign reset value
		end else begin
			q <= d;
		end
	end
	
endmodule
