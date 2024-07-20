module top_module(
	input a, 
	input b,
	output out
);

  // Declare internal wire to connect the XNOR gate inputs and output
  wire w1;
  
  // Implement XNOR gate using NAND and OR gates
  nand_gate n1(.a(a), .b(b), .out(w1)); // Connect input 'a' and 'b' to the NAND gate
  or_gate o1(.a(a), .b(b), .out(out)); // Connect input 'a' and 'b' to the OR gate
  not_gate n2(.in(out), .out(w1)); // Connect output of the OR gate to the input of the NOT gate
  
  // Disconnect the output of the inverter from the OR gate to get the XNOR functionality
  assign out = w1;

endmodule
module nand_gate(
  input a,
  input b,
  output out
);
  assign out = ~(a & b);
endmodule
module or_gate(
  input a,
  input b,
  output out
);
  assign out = a | b;
endmodule
module not_gate(
  input in,
  output out
);
  assign out = ~in;
endmodule
