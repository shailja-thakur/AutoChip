module top_module(
	input clk,
	input d,
	output reg q);

	// Initial value of the register signal q
	initial begin
		q = 1'bx;
	end
	
	// Always block triggered by the rising edge of the clock signal
	always @(posedge clk) begin
		q <= d;
	end

endmodule
