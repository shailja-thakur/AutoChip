module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_reg;

	always @(posedge clk) begin
		q_reg <= d;
	end

	// Synchronize the output q with the clock and use non-blocking assignments
	always @(posedge clk) begin
		q <= q_reg;
	end

endmodule
