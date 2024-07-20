module top_module (
	input clk,
	input x,
	output z
);

	// Flip-flop outputs
	reg q1, q2, q3;

	// D flip-flop logic
	always @(posedge clk) begin
		// XOR gate input with flip-flop q1 output
		q1 <= x ^ q1;
		// AND gate input with flip-flop q2 complemented output
		q2 <= x & ~q2;
		// OR gate input with flip-flop q3 complementary output
		q3 <= x | ~q3;
	end

	// Three-input XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
