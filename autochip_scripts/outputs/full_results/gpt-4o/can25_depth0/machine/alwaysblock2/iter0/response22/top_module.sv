module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Perform XOR operation and assign to out_assign
	assign out_assign = a ^ b;

	// always_comb block to assign value to out_always_comb
	always @* begin
		out_always_comb = out_assign;
	end

	// always_ff block to assign value to out_always_ff
	always @(posedge clk) begin
		out_always_ff = out_assign;
	end

endmodule
