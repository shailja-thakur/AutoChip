module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

// Definition of submodule flipflop
module flipflop(
	input clk,
	input D,
	output reg Q
);
	
	always @(posedge clk)
		Q <= D;
endmodule
module mux21(
	input a,
	input b,
	input sel,
	output Y
);
	
	assign Y = sel ? b : a;
endmodule
