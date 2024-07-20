module top_module(
	input x,
	input y,
	output z);
  
	wire out1, out2;
  
	// First logic gate (AND gate in this example)
	and g1(out1, x, y);
  
	// Second logic gate (OR gate in this example)
	or  g2(out2, y, x);
  
	// Third logic gate (XOR gate in this example)
	xor g3(z, out1, out2);

endmodule
