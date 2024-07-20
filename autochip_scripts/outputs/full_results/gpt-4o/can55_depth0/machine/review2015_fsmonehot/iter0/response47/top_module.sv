module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

    // State bits
    parameter S     = 10'b0000000001;
    parameter S1    = 10'b0000000010;
    parameter S11   = 10'b0000000100;
    parameter S110  = 10'b0000001000;
    parameter B0    = 10'b0000010000;
    parameter B1    = 10'b0000100000;
    parameter B2    = 10'b0001000000;
    parameter B3    = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait  = 10'b1000000000;

    // Output logic
    assign done = state[9];  // Wait state
    assign counting = state[8];  // Count state

    assign shift_ena = state[4] | state[5] | state[6] | state[7];

    assign B3_next = state[6];  // B2 state

    assign S_next = (state[0] & ~d) |
                    (state[1] & ~d) |
                    (state[3] & ~d) |
                    (state[9] & ack);

    assign S1_next = state[0] & d;  // S state and d is 1

    assign Count_next = (state[7]) |  // B3 state
                        (state[8] & ~done_counting);  // Count state and done_counting is 0

    assign Wait_next = (state[8] & done_counting) |  // Count state and done_counting is 1
                       (state[9] & ~ack);  // Wait state and ack is 0

endmodule
