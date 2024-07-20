module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	reg [7:0] q_prev;

	// D flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset)
			q <= 8'b00000000;
		else
			q <= d;
	end

	always @(posedge clk) begin
		q_prev <= q;
	end

endmodule
