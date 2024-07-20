module top_module(
	input clk,
	input a,
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Perform logical XOR operation and assign to out_assign
	assign out_assign = a ^ b;

	// Update out_always_comb whenever a or b change
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// Update out_always_ff on the rising edge of clk
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
