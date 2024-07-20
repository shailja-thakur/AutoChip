module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// XOR operation assigned to out_assign directly
	assign out_assign = a ^ b;

	// always_comb block
	always @(*) begin
		out_always_comb = out_assign;
	end

	// always_ff block
	always @(posedge clk) begin
		out_always_ff = out_assign;
	end

endmodule
