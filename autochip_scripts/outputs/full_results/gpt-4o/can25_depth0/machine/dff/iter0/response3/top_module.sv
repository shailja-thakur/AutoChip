module top_module(
	input clk,
	input d,
	output reg q);

	// Initial block to set the initial value of q
	initial begin
		q = 1'bx;  // 1'hx is a non-standard representation
	end

	// Always block to sample d on the rising edge of clk
	always @(posedge clk) begin
		q <= d;
	end

endmodule
