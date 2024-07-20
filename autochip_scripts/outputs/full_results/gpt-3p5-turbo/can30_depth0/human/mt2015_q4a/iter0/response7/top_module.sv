module top_module(
	input x,
	input y,
	output z);
	
	// Declare internal wires
	wire w1;
	
	// Implement XOR gate
	xor gate1(.A(x), .B(y), .Z(w1));
	
	// Implement AND gate
	and gate2(.A(w1), .B(x), .Z(z));
	
endmodule
