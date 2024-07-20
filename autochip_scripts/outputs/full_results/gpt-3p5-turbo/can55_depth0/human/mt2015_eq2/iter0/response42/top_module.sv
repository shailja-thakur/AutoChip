module top_module(
  input [1:0] A,
  input [1:0] B,
  output z);

  // Creating an internal wire to compare A and B
  wire [1:0] compare;
  
  // Assigning the comparison result to the "compare" wire
  assign compare = (A == B);
  
  // Assigning the output z to the MSB of the "compare" wire
  assign z = compare[1];

endmodule
