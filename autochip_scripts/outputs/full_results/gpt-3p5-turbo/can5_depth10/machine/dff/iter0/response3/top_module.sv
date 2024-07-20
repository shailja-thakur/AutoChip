module top_module(
	input wire clk,
	input wire d,
	output reg q);

	reg q;

	initial begin
		q = 1'bX;
	end

	always @(posedge clk) begin
		q <= d;
	end

endmodule
