module top_module(
	input clk,
	input d,
	output reg q);

	initial begin
		q = 1'bx; // Initial value of q to unknown.
	end

	always @(posedge clk) begin
		q <= d; // On the rising edge of clk, assign d to q
	end

endmodule
