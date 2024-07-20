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

always @(*) begin
    // Next-state logic
    B3_next = state[8] & d;
    S_next  = (state[0] & ~d) | (state[9] & ack);
    S1_next = (state[1] & ~d) | (state[2] & d);
    Count_next = state[7] & ~done_counting;
    Wait_next = (state[9] & ~ack) | (state[7] & done_counting);

    // Output logic
    done = state[9];
    counting = state[7];
    shift_ena = state[4] | state[5] | state[6] | state[7];
end

endmodule
