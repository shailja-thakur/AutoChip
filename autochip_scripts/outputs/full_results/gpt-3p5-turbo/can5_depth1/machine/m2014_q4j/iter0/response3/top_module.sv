module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Declare a wire for the carry bit
  wire carry;

  // Add the two inputs and assign the result to the output
  assign sum = {1'b0, x} + {1'b0, y};

  // Assign the carry bit to the most significant bit of the output
  assign carry = sum[4];

endmodule
