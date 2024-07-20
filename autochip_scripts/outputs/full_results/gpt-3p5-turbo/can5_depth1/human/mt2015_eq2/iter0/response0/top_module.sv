module top_module(
  input [1:0] A,
  input [1:0] B,
  output reg z  // Declare the output as a register for assignment
);

  always @* begin
    if (A == B)
      z = 1;  // Assign the value of z to 1 if A is equal to B
    else
      z = 0;  // Otherwise, assign the value of z to 0
  end

endmodule
