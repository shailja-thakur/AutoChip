module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 0;
		else if (q == 9'b111110011) // When the output register reaches 999, reset to 0
			q <= 0;
		else
			q <= q + 1;
	end
	
endmodule
