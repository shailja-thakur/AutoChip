module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal wire declaration
	wire [3:0] next_q;

	// Binary counter logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			q <= 4'b0000;
		else
			q <= next_q;
	end
	
	// Next state logic
	always @(posedge clk)
	begin
		if (q == 4'b1111) // If current count is 15
			next_q <= 4'b0000; // Reset to 0
		else
			next_q <= q + 1; // Increment count by 1
			
	end
	
endmodule
