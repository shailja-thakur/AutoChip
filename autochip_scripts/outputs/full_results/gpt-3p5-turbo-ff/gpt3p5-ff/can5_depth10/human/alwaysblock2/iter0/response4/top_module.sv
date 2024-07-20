module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// assign statement implementation
	assign out_assign = a ^ b;
	
	// combinational always block implementation
	always @*
		out_always_comb = a ^ b;
	
	// clocked always block implementation
	always @(posedge clk)
		out_always_ff <= a ^ b;
	
endmodule
