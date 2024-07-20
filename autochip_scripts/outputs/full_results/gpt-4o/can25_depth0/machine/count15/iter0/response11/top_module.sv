module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Always block that triggers on the rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset) 
			q <= 4'b0000; // Reset the counter to 0 when reset is asserted
		else 
			q <= q + 1; // Increment the counter by 1
	end

endmodule
