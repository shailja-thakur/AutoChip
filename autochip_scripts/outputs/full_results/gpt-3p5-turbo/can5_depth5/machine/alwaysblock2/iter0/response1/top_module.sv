module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);
	// Perform XOR operation on inputs a and b and assign the result to out_assign
	assign out_assign = a ^ b;

	// Assign out_assign value to out_always_comb using an always block triggered by a or b change
	always @ (a, b)
	begin
		out_always_comb = out_assign;
	end

	// Assign out_assign value to out_always_ff on the rising edge of clk
	always @(posedge clk)
	begin
		out_always_ff <= out_assign;
	end

endmodule
