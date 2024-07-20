module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  // Define the states
  parameter A = 1'b0;
  parameter B = 1'b1;

  reg state, next_state;

  // Combinational logic to determine the next state
  always @*
    if (state == A)
      next_state = j ? B : A;
    else if (state == B)
      next_state = k ? A : B;

  // Clocked logic to update the state
  always @(posedge clk or posedge areset)
    if (areset)
      state <= A;
    else
      state <= next_state;

  // Assign the output based on the current state
  always @*
    out = (state == B);

endmodule
