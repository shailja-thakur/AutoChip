module top_module(
	input x,
	input y,
	output z);

   wire gate1_out;
   wire gate2_out;

   // Instantiate the first gate (AND gate in this case)
   and gate1 (gate1_out, x, y);  // gate1_out = x AND y

   // Instantiate the second gate (OR gate in this case)
   or gate2 (gate2_out, y, x);   // gate2_out = y OR x

   // Instantiate the third gate (XOR gate in this case)
   xor gate3 (z, gate1_out, gate2_out); // z = gate1_out XOR gate2_out

endmodule
