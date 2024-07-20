module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);
	
	always @(*) begin
		out_assign = a ^ b;
	end
	
	always @(a, b) begin
		out_always_comb = a ^ b;
	end
	
	always @(posedge clk) begin
		out_always_ff <= a ^ b;
	end
	
endmodule
