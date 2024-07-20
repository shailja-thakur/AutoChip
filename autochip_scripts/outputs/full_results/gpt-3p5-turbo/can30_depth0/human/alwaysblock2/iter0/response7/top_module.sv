module top_module(
	input clk,
	input a, 
	input b,
	output out_assign,
	output reg out_always_comb,
	output reg out_always_ff
);

	assign out_assign = a ^ b;                        // using assign statement

	always @(*) begin                                 // using combinational always block
		out_always_comb = a ^ b;
	end

	always @(posedge clk) begin                        // using clocked always block
		out_always_ff <= a ^ b;
	end

endmodule
