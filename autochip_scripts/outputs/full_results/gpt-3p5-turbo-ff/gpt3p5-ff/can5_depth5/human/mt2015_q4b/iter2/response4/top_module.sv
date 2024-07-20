module top_module(
  input x,
  input y,
  output z);

  reg z;  // Declare z as a register

  always @(*) begin
    if (x & y)  // If x and y are both high
      z = 1;    // Set z to high
    else
      z = 0;    // Otherwise, set z to low
  end
  
endmodule
