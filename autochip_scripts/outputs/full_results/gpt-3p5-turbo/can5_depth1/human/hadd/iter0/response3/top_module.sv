module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Declare internal wire for the carry-out
  wire co;

  // Implement half adder logic
  assign sum = a ^ b;
  assign co = a & b;

  // Output assignments
  assign cout = co;
endmodule
