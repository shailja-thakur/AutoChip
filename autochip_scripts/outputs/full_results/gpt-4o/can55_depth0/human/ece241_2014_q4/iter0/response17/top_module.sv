module top_module (
	input clk,
	input x,
	output z
);

	// Intermediate flip-flop outputs
	reg q_xor, q_and, q_or;
	
	// Complementary outputs of flip-flops
	wire not_q_xor = ~q_xor;
	wire not_q_and = ~q_and;
	wire not_q_or = ~q_or;
	
	// Gates connected to D flip-flop inputs
	wire d_xor = x ^ q_xor;
	wire d_and = x & not_q_and;
	wire d_or = x | not_q_or;
	
	// Three-input XNOR gate producing the output z
	assign z = ~(d_xor ^ d_and ^ d_or);
	
	// D flip-flops with synchronous reset (default reset state of 0)
	always @(posedge clk) begin
		q_xor <= d_xor;
		q_and <= d_and;
		q_or <= d_or;
	end
	
endmodule
