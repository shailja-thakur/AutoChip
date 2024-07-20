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

    // State transition logic
    always @*
    begin
        B3_next = state[9];              // B3_next = B3
        S_next = (state[9] & ~d) | (state[0] & d);   // S_next = B3 & ~d + S & d = B3_next | S_next
        S1_next = (~d & state[0]) | (d & state[1]);  // S1_next = ~d & S + d & S1 = ~d & S + d & S1_next
        Count_next = state[7] & ~done_counting;    // Count_next = Count & ~done_counting = Count_next
        Wait_next = state[7] & done_counting;      // Wait_next = Count & done_counting = Wait_next
    end
    
    // Output logic
    always @*
    begin
        done = state[8];               // done = Wait
        counting = state[7];           // counting = Count
        shift_ena = (state[9] == 1'b0) ? 1'b1 : 1'b0;   // shift_ena = B0 or ~B3
    end

endmodule
