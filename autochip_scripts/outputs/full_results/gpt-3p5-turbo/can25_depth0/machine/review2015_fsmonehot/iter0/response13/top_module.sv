module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

  reg B3_active;
  reg S_active;
  reg S1_active;
  reg Count_active;

  always @(*) begin
    B3_active = state[3];
    S_active = state[0] & ~d | state[2] & ~d | state[6] & ~d | state[9] & ack;
    S1_active = state[0] & d;
    Count_active = state[7] | state[8] & ~done_counting;
  end

  always @(B3_active, S_active, S1_active, Count_active) begin
    B3_next = B3_active & state[2];
    S_next = S_active;
    S1_next = S1_active;
    Count_next = Count_active;
    Wait_next = Count_active & done_counting | state[9] & ~ack;
  end

  always @(state[3], state[6], state[7], state[8]) begin
    shift_ena = state[3] | state[6] | state[7] | state[8];
  end

  assign done = state[9];
  assign counting = state[7] | state[8];
endmodule
