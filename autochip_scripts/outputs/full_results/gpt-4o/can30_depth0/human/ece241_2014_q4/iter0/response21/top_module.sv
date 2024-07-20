module top_module (
	input clk,
	input x,
	output z
);

	// Registers for flip-flop outputs
	reg q_xor, q_and, q_or;

	// Wires for the complemented outputs
	wire q_and_n, q_or_n;

	// Complemented outputs
	assign q_and_n = ~q_and;
	assign q_or_n = ~q_or;

	// Logic for D inputs
	wire d_xor, d_and, d_or;
	assign d_xor = x ^ q_xor;
	assign d_and = x & q_and_n;
	assign d_or = x | q_or_n;

	// D Flip-Flops
	always @(posedge clk) begin
		q_xor <= d_xor;
		q_and <= d_and;
		q_or <= d_or;
	end

	// XNOR gate with the outputs of the flip-flops
	assign z = ~(q_xor ^ q_and ^ q_or);

endmodule
