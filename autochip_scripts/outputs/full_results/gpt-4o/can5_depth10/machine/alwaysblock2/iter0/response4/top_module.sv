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

	// Create always_comb block to assign out_always_comb
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// Create always_ff block to assign out_always_ff synchronously with clk
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
