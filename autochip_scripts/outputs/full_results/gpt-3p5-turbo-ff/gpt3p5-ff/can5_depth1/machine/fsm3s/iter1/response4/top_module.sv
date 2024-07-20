module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  // definition of states
  typedef enum logic [1:0] {
    A,
    B,
    C,
    D
  } state_type;

  // state register
  reg state_type current_state, next_state;

  always_ff @(posedge clk or posedge reset)
  if (reset) begin
    current_state <= A;
    out <= 0;
  end
  else begin
    current_state <= next_state;
    out <= (current_state == D);
  end

  always_comb
  case (current_state)
    A:
    begin
      if (in)
        next_state = B;
      else
        next_state = A;
    end
    B:
    begin
      if (in)
        next_state = B;
      else
        next_state = C;
    end
    C:
    begin
      if (in)
        next_state = D;
      else
        next_state = A;
    end
    D:
    begin
      if (in)
        next_state = B;
      else
        next_state = C;
    end
  endcase

endmodule
