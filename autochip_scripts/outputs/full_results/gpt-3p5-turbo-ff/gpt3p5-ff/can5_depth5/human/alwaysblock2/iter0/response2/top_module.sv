module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	// assign statement method
	assign out_assign = a ^ b;

	// combinational always block method
	always @(*) begin
		out_always_comb = a ^ b;
	end

	// clocked always block method
	always @(posedge clk) begin
		out_always_ff <= a ^ b;
	end

endmodule
