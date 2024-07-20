module top_module(
	input clk,
	input d,
	output reg q);
	
	// Initial block to set the initial value of the register signal q
	initial begin
		q = 1'hx;  // Initializing q to 1'hx
	end
	
	// Always block triggered by the rising edge of the clock signal
	always @(posedge clk) begin
		q <= d;  // Setting q to the value of d at the rising edge of clk
	end
	
endmodule
