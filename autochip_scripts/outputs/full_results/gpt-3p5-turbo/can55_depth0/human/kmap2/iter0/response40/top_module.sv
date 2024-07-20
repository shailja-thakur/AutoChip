module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Define internal signals
	wire w1, w2, w3, w4;

	// Implement the circuit
	and gate1 (w1, a, b);
	and gate2 (w2, c, ~d);
	xor gate3 (w3, w1, w2);
	or gate4 (w4, w3, ~a, ~c);
	assign out = w4;

endmodule
