module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	// Always block triggered on the positive edge of the clock or the positive edge of the reset
	always @(posedge clk or posedge reset) begin
		if (reset) 
			q <= 10'b0; // Reset the counter to 0
		else if (q == 10'd999) 
			q <= 10'b0; // Reset the counter to 0 when it reaches 999
		else 
			q <= q + 1'b1; // Increment the counter by 1
	end
endmodule
