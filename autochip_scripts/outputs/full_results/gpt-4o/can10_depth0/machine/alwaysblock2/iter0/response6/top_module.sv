module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Assign the XOR operation result to out_assign
	assign out_assign = a ^ b;
	
	// Use an always block for combinational logic to assign out_always_comb
	always @(*) begin
		out_always_comb = a ^ b;
	end
	
	// Use an always block for sequential logic to assign out_always_ff
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end
	
endmodule
