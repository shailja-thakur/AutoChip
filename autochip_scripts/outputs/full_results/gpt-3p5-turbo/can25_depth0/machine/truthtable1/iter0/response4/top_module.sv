module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
  
	// Define internal wires
	wire w1, w2, w3, w4;
	
	// AND gates
	and gate1(w1, ~x3, x2, ~x1);
	and gate2(w2, ~x3, x2, x1);
	and gate3(w3, x3, ~x2, x1);
	and gate4(w4, x3, x2, x1);
	
	// OR gate
	or gate5(f, w1, w2, w3, w4);

endmodule
