module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);
  reg [1:0] current_state;

  always_comb begin
    case (state)
      2'b00: // state A
        if (in)
          next_state = 2'b01; // transition to state B
        else
          next_state = 2'b00; // stay in state A
      2'b01: // state B
        if (in)
          next_state = 2'b01; // stay in state B
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
      default:
        next_state = 2'b00; // default case, should never happen
    endcase
  end

  always @(posedge clk) begin
    current_state <= state;
    state <= next_state;
  end

  assign out = (current_state == 2'b11);

endmodule
