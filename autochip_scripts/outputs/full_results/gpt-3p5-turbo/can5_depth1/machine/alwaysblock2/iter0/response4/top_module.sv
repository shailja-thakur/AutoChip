module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign statement to calculate XOR of a and b and assign it to out_assign
	assign out_assign = a ^ b;

	// Always block that assigns out_assign value to out_always_comb on any change in a or b
	always @(a or b)
	begin
		out_always_comb <= out_assign;
	end

	// Always block that assigns out_assign value to out_always_ff on the rising edge of clk
	always @(posedge clk)
	begin
		out_always_ff <= out_assign;
	end

endmodule
