module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output reg out
);

  always_comb begin
    case (state)
      2'b00: // state A
        if (in)
          next_state = 2'b01; // transition to state B
        else
          next_state = 2'b00; // remain in state A
      2'b01: // state B
        if (in)
          next_state = 2'b01; // remain in state B
        else
          next_state = 2'b10; // transition to state C
      2'b10: // state C
        if (in)
          next_state = 2'b11; // transition to state D
        else
          next_state = 2'b00; // transition to state A
      2'b11: // state D
        if (in)
          next_state = 2'b01; // transition to state B
        else
          next_state = 2'b10; // transition to state C
    endcase
  end

  always_comb begin
    if (state == 2'b11) // state D
      out = 1'b1;
    else
      out = 1'b0;
  end

endmodule
