module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Intermediate wire to calculate the sum
  wire [1:0] sum_wire = a + b + cin;

  // Assign the sum output as the result of the addition modulo 2
  assign sum = sum_wire[0];

  // Assign the cout output based on the sum_wire value
  assign cout = sum_wire[1];

endmodule
