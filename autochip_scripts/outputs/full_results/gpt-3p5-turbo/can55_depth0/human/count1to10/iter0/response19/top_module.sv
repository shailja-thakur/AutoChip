module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			q <= 4'b0001; // Reset the counter to 1
		else
		begin
			if (q == 4'b1010) // Check if the counter has reached 10
				q <= 4'b0001;	// Reset the counter to 1
			else
				q <= q + 1;	// Increment the counter by 1
		end
	end
endmodule
