module top_module(
	input clk,
	input d,
	output reg q);

	// Initialize q to unknown/undefined value 1'hx
	initial begin
		q = 1'bx;
	end

	// On the rising edge of the clock, assign q the value of d
	always @(posedge clk) begin
		q = d;
	end
	
endmodule
