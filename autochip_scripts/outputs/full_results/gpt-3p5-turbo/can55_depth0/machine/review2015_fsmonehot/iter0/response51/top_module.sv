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
 
 always @* begin
    B3_next = (state[7] == 1'b1);     // B3_next is 1 when the state B2 is active
    S_next = ((state[9] == 1'b1 && d == 1'b0) ||     // S_next is 1 when the state S and d is 0, or state S1 and d is 0, or state S110 and d is 0, or state Wait and ack is 1
              (state[6] == 1'b1 && d == 1'b0) ||
              (state[7] == 1'b1 && state[6] == 1'b1 && state[3] == 1'b1 && d == 1'b0) ||
              (state[0] == 1'b1 && ack == 1'b1));
    S1_next = ((state[9] == 1'b1 && d == 1'b1));     // S1_next is 1 when the state S and d is 1
    Count_next = ((state[7] == 1'b1) ||     // Count_next is 1 when the state B3 is active, or the state Count and done_counting is 0
                  (state[5] == 1'b1 && done_counting == 1'b0));
    Wait_next = ((state[5] == 1'b1 && done_counting == 1'b1) ||     // Wait_next is 1 when the state Count and done_counting is 1, or the state Wait and ack is 0
                 (state[0] == 1'b1 && ack == 1'b0));
                 
    done = (state[1] == 1'b1);    // done signal is 1 in the state Wait
    counting = (state[5] == 1'b1);    // counting signal is 1 in the state Count
    shift_ena = ((state[7] == 1'b1) ||     // shift_ena signal is 1 if any of the states B3, B2, B1, and B0 is active
                 (state[6] == 1'b1) ||
                 (state[3] == 1'b1) ||
                 (state[2] == 1'b1));
 end
 
endmodule
