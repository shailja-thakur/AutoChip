module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Create 8 D flip-flops with active high synchronous reset
	reg [7:0] internal_q;
	always @(negedge clk) begin
		if (reset) begin
			internal_q <= 8'h34;
		end else begin
			internal_q <= d;
		end
	end

	// Output q
	assign q = internal_q;
endmodule
