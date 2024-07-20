module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

  // Implement the truth table equations using logic gates
  wire gate_00 = a & (~b) & (~c) & d;
  wire gate_01 = a & (~b) & (~c) & (~d);
  wire gate_11 = (~a) & (~b) & c & d;
  wire gate_10 = a & b & (~c) & (~d);

  // Use OR gates to combine the outputs of each gate
  assign out = gate_00 | gate_01 | gate_11 | gate_10;
  
endmodule
