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

	// Assign the value using always_comb block
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// Assign the value using always_ff block (synchronous with clk)
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
