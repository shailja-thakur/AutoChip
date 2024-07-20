module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	// Create 8 D flip-flops with active high asynchronous reset
	reg [7:0] q_temp;
	always @(posedge clk or posedge areset) begin
		if (areset)
			q_temp <= 8'b0;
		else
			q_temp <= d;
	end

	// Output should be reset to 0
	always @(posedge clk) begin
		if (areset)
			q <= 8'b0;
		else
			q <= q_temp;
	end

endmodule
