module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Perform XOR operation and assign result to out_assign
	assign out_assign = a ^ b;
	
	// Perform the same operation in an always_comb block
	always @(*) begin
		out_always_comb = a ^ b;
	end
	
	// Perform the same operation in an always_ff block
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
