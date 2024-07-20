module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_reg;

	// Use non-blocking assignment to synchronize the output q with the clock
	always @(posedge clk) begin
		q_reg <= d;
		q <= q_reg;
	end

endmodule
