module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	// D flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 8'b00000000;
		end else begin
			q <= d;
		end
	end

endmodule
