module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal wires
  wire w1;
  wire w2;
  
  // Instantiate the full adder
  full_adder u1 (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(w1),
    .sum(w2)
  );
  
  // Connect the outputs of the full adder to the outputs of the top module
  assign cout = w1;
  assign sum = w2;
  
endmodule
