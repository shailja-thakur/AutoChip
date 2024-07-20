module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	// Define internal wires
	wire w1, w2, w3;

	// Implement the circuit
	assign w1 = a & c;
	assign w2 = ~b & d;
	assign w3 = w1 | w2;
	assign out = ~w3;

endmodule
