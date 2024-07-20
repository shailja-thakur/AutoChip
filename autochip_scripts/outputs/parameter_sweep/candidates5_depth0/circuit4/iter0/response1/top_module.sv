module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal wires and registers
	wire w1, w2, w3, w4, w5, w6, w7;

	// Implement the circuit
	assign w1 = a & c;
	assign w2 = b & d;
	assign w3 = ~(a | b);
	assign w4 = ~(c | d);
	assign w5 = w1 & w4;
	assign w6 = w2 & w3;
	assign w7 = w5 | w6;
	assign q = ~(w7 | (~a & ~b));

endmodule
