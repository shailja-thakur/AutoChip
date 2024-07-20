module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	// Internal signals
	reg [3:0] next_q;

	// Counter logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 4'b0001;
		else if (q == 4'b1010)
			next_q <= 4'b0001;
		else
			next_q <= q + 1;
	end
	
	// Output assignment
	always @(posedge clk) begin
		q <= next_q;
	end
endmodule
