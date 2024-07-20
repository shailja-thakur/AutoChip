module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire areset,
	output reg [7:0] q);

	// Create 8 D flip-flops with active high asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 8'b0;
		end else begin
			q <= d;
		end
	end
endmodule
