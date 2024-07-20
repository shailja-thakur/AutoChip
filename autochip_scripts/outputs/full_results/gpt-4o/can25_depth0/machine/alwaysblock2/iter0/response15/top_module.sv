module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Perform logical XOR operation on a and b, assign result to out_assign
	assign out_assign = a ^ b;

	// Always block for out_always_comb, triggers on any change in a or b
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// Always block for out_always_ff, triggers on rising edge of clk
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
