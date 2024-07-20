module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output out_always_comb,
	output out_always_ff
);
	assign out_assign = a ^ b;
	
	always @*
		out_always_comb = a ^ b;
	
	always @(posedge clk)
		out_always_ff <= a ^ b;
endmodule
