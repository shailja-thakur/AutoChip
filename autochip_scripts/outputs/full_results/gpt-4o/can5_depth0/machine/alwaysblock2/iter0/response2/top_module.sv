module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);
	
	// Perform XOR operation and assign directly to out_assign
	assign out_assign = a ^ b;

	// Always block for combinational logic
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// Always block for sequential logic
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end

endmodule
