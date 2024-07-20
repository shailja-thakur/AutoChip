module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign the result of XOR operation to out_assign
	assign out_assign = a ^ b;

	// Assign the result using an always_comb block
	always @* begin
		out_always_comb = a ^ b;
	end

	// Assign the result using an always_ff block triggered by clock edge
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end
endmodule
