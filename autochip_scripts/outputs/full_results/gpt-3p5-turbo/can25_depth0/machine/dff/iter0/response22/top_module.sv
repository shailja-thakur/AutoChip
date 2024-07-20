module top_module(
	input clk,
	input d,
	output reg q);

	// Initial block to set the initial value of q
	initial begin
		q = 1'bX;
	end

	// Always block to synchronize d with clk
	always @(posedge clk) begin
		q <= d;
	end

endmodule
