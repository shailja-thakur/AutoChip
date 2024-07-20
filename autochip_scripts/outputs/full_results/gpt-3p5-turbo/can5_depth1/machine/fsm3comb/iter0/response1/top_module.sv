module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output reg out
);

  always_comb begin
    case (state)
      2'b00: // State A
        if (in)
          next_state = 2'b01; // Transition to State B
        else
          next_state = 2'b00; // Remain in State A
      2'b01: // State B
        if (in)
          next_state = 2'b01; // Remain in State B
        else
          next_state = 2'b10; // Transition to State C
      2'b10: // State C
        if (in)
          next_state = 2'b11; // Transition to State D
        else
          next_state = 2'b00; // Transition to State A
      2'b11: // State D
        if (in)
          next_state = 2'b01; // Transition to State B
        else
          next_state = 2'b10; // Transition to State C
    endcase
  end

  always_comb begin
    if (state == 2'b11) // State D
      out = 1'b1;
    else
      out = 1'b0;
  end

endmodule
