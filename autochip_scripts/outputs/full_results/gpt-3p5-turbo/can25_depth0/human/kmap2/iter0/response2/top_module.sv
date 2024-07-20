module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implement the circuit described by the Karnaugh map
	
	// Intermediate signals
	wire w1, w2, w3;
	
	// Logic gates
	or gate1(w1, a, b);
	and gate2(w2, c, d);
	xor gate3(w3, w1, w2);
	
	// Output
	assign out = w3;
	
endmodule
