module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (reset) 
			q <= 4'b0000; // Reset counter to 0
		else if (q == 4'b1001)
			q <= 4'b0000; // Wrap around to 0 when counter reaches 9
		else
			q <= q + 1;
	end

endmodule
