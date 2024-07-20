module top_module (
	input clk,
	input a, 
	output reg q
);

	// Always block triggered on positive edge of the clock signal
	always @(posedge clk) begin
		q <= ~a; // Set q to the inverse of a
	end

endmodule
