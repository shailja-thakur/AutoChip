module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 1;
		else if (q == 10) // Check if output register reaches 10
			q <= 1; // Reset to 1
		else
			q <= q + 1; // Increment by one
	end
	
endmodule
