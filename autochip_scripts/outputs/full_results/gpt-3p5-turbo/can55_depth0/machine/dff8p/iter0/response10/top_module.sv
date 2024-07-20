module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] reg_value;
	
	always @(negedge clk) begin
		if (reset) begin
			q <= 8'h34;
		end else begin
			reg_value <= d;
			q <= reg_value;
		end
	end
endmodule
