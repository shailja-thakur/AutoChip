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
 
  reg [9:0] next_state;
 
  always @* begin
    next_state = state;
    case(state)
      S:
        if (d == 0) next_state = S_next ? S1 : S;
      S1:
        if (d == 0) next_state = S1;
        if (d == 1) next_state = S1_next ? S11 : S1;
      S11:
        next_state = S11;
      S110:
        next_state = S110;
      B0:
        next_state = B0;
      B1:
        next_state = B1;
      B2:
        if (next_state == B2) next_state = B3_next ? B2 : B1;
      B3:
        if (next_state == B3) next_state = B3;
      Count:
        if (done_counting == 0) next_state = Count_next ? B3 : Count;
        if (done_counting == 1) next_state = Count_next ? B3 : Wait;
      Wait:
        if (ack == 1) next_state = Wait_next ? S : Wait;
        if (ack == 0) next_state = Wait_next ? Count : Wait;
    endcase
  end
 
  // Output assignments
  assign done = (state == Wait) ? 1 : 0;
  assign counting = (state == Count) ? 1 : 0;
  assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1 : 0;
 
  always @(posedge clk) begin
    state <= next_state;
  end
endmodule
