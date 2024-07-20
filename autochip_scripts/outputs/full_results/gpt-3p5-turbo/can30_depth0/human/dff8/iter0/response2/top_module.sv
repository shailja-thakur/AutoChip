module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);
	
	reg [7:0] q; // Declare a register for q
	
	always @(posedge clk)begin // Trigger on positive edge of clk
		q <= d;
	end
	
endmodule
