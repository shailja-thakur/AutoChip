module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_next;
	
	always @(posedge clk)
	begin
		if (reset)
			q_next <= 8'b0;
		else
			q_next <= d;
	end
	
	always @(posedge clk)
	begin
		if (reset)
			q <= 8'b0;
		else
			q <= q_next;
	end
	
endmodule
