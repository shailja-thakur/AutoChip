module top_module (
	input clk,
	input a,
	output reg q
);

	// Always block triggered on positive edge of the clock
	always @(posedge clk)
	begin
		// Update the output q to the inverse of input a
		q <= ~a;
	end

endmodule
