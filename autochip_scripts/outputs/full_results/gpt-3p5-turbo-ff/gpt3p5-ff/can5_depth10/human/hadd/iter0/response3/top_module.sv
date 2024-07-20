module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Declare internal wires
  wire x1, x2;
  
  // Instantiate XOR gate for sum
  xor #(1) xor_gate (
    .a(a),
    .b(b),
    .z(x1)
  );
  
  // Instantiate AND gate for carry-out
  and #(1) and_gate (
    .a(a),
    .b(b),
    .z(x2)
  );
  
  // Assign internal wires to outputs
  assign sum = x1;
  assign cout = x2;
  
endmodule
