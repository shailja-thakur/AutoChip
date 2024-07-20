module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);
	
	// Add initial block to set the output to a default value of 8'h0 
	initial begin
		q = 8'h0;
	end
	
	// Add always block triggered on the rising edge of the clock input
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
