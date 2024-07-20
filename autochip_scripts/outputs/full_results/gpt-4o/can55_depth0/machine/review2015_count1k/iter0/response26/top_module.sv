module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 10'b0; // Reset q to 0
		else if (q == 999)
			q <= 10'b0; // Reset q to 0 when it reaches 999
		else
			q <= q + 1; // Increment q by 1
	end

endmodule
