module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Create 8 D flip-flops with active high synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			q <= 8'b0;
		end else begin
			q <= d;
		end
	end

endmodule
