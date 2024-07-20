module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// XOR operation and direct assignment to out_assign
	assign out_assign = a ^ b;

	// always_comb block to assign value to out_always_comb
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// always_ff block to assign value to out_always_ff on rising edge of clk
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
