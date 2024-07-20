module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign out_assign with XOR operation result of a and b
	assign out_assign = a ^ b;

	// Assign out_always_comb with the same value as out_assign using always block
	always @(*) begin
		out_always_comb = a ^ b;
	end
	
	// Assign out_always_ff with the same value as out_assign using always block triggered on clk's rising edge
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
