module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  // Declare state register
  reg state;
  
  // Declare next state signal
  reg next_state;

  // Combinational logic to determine next state
  always @*
  begin
    case(state)
      A: next_state = (j) ? B : A;
      B: next_state = (k) ? A : B;
    endcase
  end

  // Clocked always block to update state based on next_state and areset
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= A;
    else
      state <= next_state;
  end

  // Assign output signal based on current state
  assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
