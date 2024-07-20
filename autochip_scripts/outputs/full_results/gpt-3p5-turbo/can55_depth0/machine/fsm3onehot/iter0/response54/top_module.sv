module top_module (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

  // Assign statements for next_state
  
  // Assign statement for next_state[A]
  always @(*) begin
    if (in == 1'b0)
      next_state[0] = state[0] | state[2];
    else
      next_state[0] = 1'b0;
  end
  
  // Assign statement for next_state[B]
  always @(*) begin
    if (in == 1'b0)
      next_state[1] = 1'b0;
    else
      next_state[1] = state[0] | state[1] | state[3];
  end
  
  // Assign statement for next_state[C]
  always @(*) begin
    if (in == 1'b0)
      next_state[2] = state[1] | state[3];
    else
      next_state[2] = 1'b0;
  end
  
  // Assign statement for next_state[D]
  always @(*) begin
    if (in == 1'b0)
      next_state[3] = 1'b0;
    else
      next_state[3] = state[2];
  end
  
  // Assign statement for out
  assign out = state[3];

endmodule
