module top_module(
	input wire clk,
	input wire d,
	output reg q);

	reg [0:0] q;

	initial begin
		q = 1'bx;
	end

	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
