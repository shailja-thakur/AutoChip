module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);
	
	reg [7:0] q_temp;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			q_temp <= 0;
		else
			q_temp <= d;
	end
	
	always @(posedge clk) begin
		q <= q_temp;
	end
	
endmodule
