module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) 
			q <= 4'b0000;
		else if (q == 4'b1001)  // Check if q is 9
			q <= 4'b0000;
		else
			q <= q + 1'b1;  // Increment q by 1
	end
	
endmodule
