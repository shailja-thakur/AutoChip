module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// assign out_assign port with XOR operation of a and b
	assign out_assign = a ^ b;

	// always_comb block to assign out_always_comb with value of out_assign
	always_comb begin
		out_always_comb = out_assign;
	end

	// always_ff block triggered on rising edge of clk to assign out_always_ff with value of out_assign
	always @(posedge clk) begin
		out_always_ff <= out_assign;
	end

endmodule
