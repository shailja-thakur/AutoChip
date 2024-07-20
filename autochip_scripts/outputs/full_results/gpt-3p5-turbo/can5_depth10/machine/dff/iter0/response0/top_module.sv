module top_module(
	input clk,
	input d,
	output reg q);
	
	// initial block to set the initial value of q
	initial begin
		q = 1'hx;
	end
	
	// always block triggered by the rising edge of clk
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
