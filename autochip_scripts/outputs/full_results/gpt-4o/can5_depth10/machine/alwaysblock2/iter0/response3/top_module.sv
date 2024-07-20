module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// Direct assignment using continuous assignment
	assign out_assign = a ^ b;

	// Assignment using always_comb block
	always @* begin
		out_always_comb = a ^ b;
	end

	// Assignment using always_ff block synchronous to the clock
	always @(posedge clk) begin
		out_always_ff = a ^ b;
	end
	
endmodule
