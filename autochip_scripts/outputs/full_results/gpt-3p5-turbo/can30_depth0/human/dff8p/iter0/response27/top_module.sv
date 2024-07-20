module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] q_tmp;

	always @(negedge clk or posedge reset) begin
		if (reset)
			q_tmp <= 8'b00110100;
		else
			q_tmp <= d;
	end

	always @(posedge clk) begin
		q <= q_tmp;
	end

endmodule
