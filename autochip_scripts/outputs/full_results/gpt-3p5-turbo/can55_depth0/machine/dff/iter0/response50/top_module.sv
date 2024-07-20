module top_module(
	input clk,
	input d,
	output reg q);

	// Set the initial value of q to 1'hx
	initial begin
		q = 1'hx;
	end

	// Assign the value of d to q on the rising edge of clk
	always @(posedge clk) begin
		q <= d;
	end

endmodule
