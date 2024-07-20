module top_module (
	input clk,
	input a,
	input b,
	output reg out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign statement for XOR gate
	assign out_assign = a ^ b;

	// Combinational always block for XOR gate
	always @*
	begin
		out_always_comb = a ^ b;
	end

	// Clocked always block for XOR gate
	always @(posedge clk)
	begin
		out_always_ff <= a ^ b;
	end

endmodule
