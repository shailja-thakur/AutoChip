module top_module(
	input wire clk,
	input wire a, 
	input wire b,
	output wire out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign the XOR of a and b to out_assign
	assign out_assign = a ^ b;

	// Always block for combinational logic
	always @(*) begin
		out_always_comb = out_assign;
	end

	// Always block for sequential logic, triggered on the rising edge of the clock
	always @(posedge clk) begin
		out_always_ff = out_assign;
	end

endmodule
