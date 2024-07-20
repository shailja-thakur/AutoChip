module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);

  reg [9:0] next_state_reg;

  assign out1 = state[8] | state[9];
  assign out2 = state[7] | state[9];

  always @(*) begin
    next_state_reg[0] = ~in & (|state[4:0], state[7], state[8], state[9]);
    next_state_reg[1] = in & (state[0] | state[8] | state[9]);
    next_state_reg[2] = in & state[1];
    next_state_reg[3] = in & state[2];
    next_state_reg[4] = in & state[3];
    next_state_reg[5] = in & state[4];
    next_state_reg[6] = in & state[5];
    next_state_reg[7] = in & (state[6] | state[7]);
    next_state_reg[8] = ~in & state[5];
    next_state_reg[9] = ~in & state[6];
  end

  assign next_state = next_state_reg;

endmodule
