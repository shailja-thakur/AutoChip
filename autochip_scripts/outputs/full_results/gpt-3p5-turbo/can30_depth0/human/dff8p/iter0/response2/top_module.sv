module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] q_next;
	
	always @(negedge clk) begin
		if (reset)
			q_next <= 8'b00110100;
		else
			q_next <= d;
	end
	
	always @(posedge clk) begin
		q <= q_next;
	end
endmodule
