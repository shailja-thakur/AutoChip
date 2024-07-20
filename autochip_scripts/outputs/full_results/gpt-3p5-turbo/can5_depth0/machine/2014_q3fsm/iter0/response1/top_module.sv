module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

  // Declare the states
  enum state {A, B, C, S10, S11, S20, S21, S22};
  reg [2:0] current_state, next_state;

  // Assign initial state
  always @ (posedge clk or posedge reset) begin
    if (reset)
      current_state <= A;
    else
      current_state <= next_state;
  end

  // Assign next state
  always_comb begin
    case (current_state)
      A: if (s) next_state = B;
      B: if (w) next_state = S11; else next_state = S10;
      C: if (w) next_state = S11; else next_state = S10;
      S10: if (w) next_state = S21; else next_state = S20;
      S11: if (w) next_state = S22; else next_state = S21;
      S20: next_state = B;
      S21: if (w) next_state = C; else next_state = B;
      S22: if (w) next_state = B; else next_state = C;
    endcase
  end

  // Assign outputs
  always_comb begin
    case (current_state)
      A, B, C: z = 0;
      default: z = 1;
    endcase
  end

endmodule
