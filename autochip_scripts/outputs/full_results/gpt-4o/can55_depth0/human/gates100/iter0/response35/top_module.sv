module top_module (
	input [99:0] in,
	output reg out_and,
	output reg out_or,
	output reg out_xor
);

	// always block to evaluate out_and, out_or and out_xor
	always @(*) begin 
		out_and = &in;    // AND reduction to get output AND of all inputs
		out_or = |in;     // OR reduction to get output OR of all inputs
		out_xor = ^in;    // XOR reduction to get output XOR of all inputs
	end

endmodule
