module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Declare internal wire for carry out
  wire c;

  // Assign sum and carry out using full adder
  assign {cout, sum} = a + b + c;

endmodule
