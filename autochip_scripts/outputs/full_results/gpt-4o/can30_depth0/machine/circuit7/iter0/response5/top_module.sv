module top_module (
	input clk,
	input a, 
	output reg q
);

	// Always block with sensitivity to the positive edge of the clock
	always @(posedge clk) begin
		q <= ~a;  // Set q to the inverse of a
	end

endmodule
