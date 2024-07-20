module top_module(
	input x,
	input y,
	output z);
  
  // Create intermediate signals for the XOR and NOT operations
  wire xor_out;
  wire not_out;
  
  // Perform XOR operation on inputs x and y
  xor #(1) u1 (
    .A(x),
    .B(y),
    .Z(xor_out)
  );
  
  // Perform NOT operation on the XOR output
  not #(1) u2 (
    .A(xor_out),
    .Z(not_out)
  );
  
  // Assign the NOT output to the final output z
  assign z = not_out;
  
endmodule
