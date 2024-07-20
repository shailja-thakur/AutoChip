module top_module(
	input x,
	input y,
	output z);

  wire a;
  wire b;

  // First gate
  and(first_gate_output, x, y);
  
  // Second gate
  xor(second_gate_output, x, y);
  
  // Third gate
  or(z, first_gate_output, second_gate_output);
  
endmodule
