module top_module(
	input clk,
	input d,
	output reg q);

	// Set initial value of q to 1'hx
	initial begin
		q = 1'hx;
	end

	// Synchronize data signal d with clock signal clk
	always @(posedge clk) begin
		q <= d;
	end

endmodule
