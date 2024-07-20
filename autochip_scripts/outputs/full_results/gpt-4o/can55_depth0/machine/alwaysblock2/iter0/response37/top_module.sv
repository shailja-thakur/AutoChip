module top_module (
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign the result of a XOR b to out_assign
	assign out_assign = a ^ b;

	// Use always_comb block to assign the same value to out_always_comb
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// Use always_ff block to assign the same value to out_always_ff on the rising edge of clk
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
