module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// 8 D flip-flops
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
