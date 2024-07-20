module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal wire and reg declarations
	wire [3:0] next_q;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 4'b0001;
		else
			q <= next_q;
	end

	// Combinational logic for next state calculation
	always @(posedge clk) begin
		if (q === 4'b1010)
			next_q <= 4'b0001;
		else
			next_q <= q + 1;
	end

endmodule
