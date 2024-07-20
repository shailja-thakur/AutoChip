module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign output using continuous assignment
	assign out_assign = a ^ b;

	// Assign output using always_comb block
	always @(*)
	begin
		out_always_comb = a ^ b;
	end

	// Assign output using always_ff block with clock edge trigger
	always @(posedge clk)
	begin
		out_always_ff = a ^ b;
	end

endmodule
