module top_module (
	input clk,
	input x,
	output z
);

	// Internal signals
	reg q1, q2, q3;
	wire x_xor_q1, x_and_not_q2, x_or_not_q3;

	// XOR gate
	assign x_xor_q1 = x ^ q1;
	// AND gate with complement of q2
	assign x_and_not_q2 = x & ~q2;
	// OR gate with complement of q3
	assign x_or_not_q3 = x | ~q3;

	// D Flip-flops
	always @(posedge clk) begin
		q1 <= x_xor_q1;
		q2 <= x_and_not_q2;
		q3 <= x_or_not_q3;
	end

	// XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
