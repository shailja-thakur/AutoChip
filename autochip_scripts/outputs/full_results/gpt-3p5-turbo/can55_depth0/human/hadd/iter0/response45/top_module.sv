module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Declaration of internal wires
  wire s, c;

  // Implementation of half adder logic
  xor(s, a, b);
  and(c, a, b);

  // Assigning output ports
  assign sum = s;
  assign cout = c;
  
endmodule
