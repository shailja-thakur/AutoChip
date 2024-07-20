module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Define the internal signals
	wire w1, w2, w3, w4;

	// Implement the circuit
	and gate1(w1, a, ~b, c);
	or gate2(w2, a, b, ~c);
	or gate3(w3, a, b, c);
	or gate4(w4, ~a, b, c);
	or out(w1, w2, w3, w4);
	
endmodule
