module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,   // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

    // Define state bits
    localparam S = 10'b0000000001,
               S1 = 10'b0000000010,
               S11 = 10'b0000000100,
               S110 = 10'b0000001000,
               B0 = 10'b0000010000,
               B1 = 10'b0000100000,
               B2 = 10'b0001000000,
               B3 = 10'b0010000000,
               COUNT = 10'b0100000000,
               WAIT = 10'b1000000000;

    // Define outputs based on state and inputs
    
    // done signal is 1 in the WAIT state
    assign done = (state == WAIT);

    // counting signal is 1 in the COUNT state
    assign counting = (state == COUNT);

    // shift_ena signal is 1 if any of the B0, B1, B2, B3 states are active
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);

    // B3_next is 1 when the B2 state is active
    assign B3_next = (state == B2);

    // S_next is 1 when in state S and d is 0, or state S1 and d is 0, or state S110 and d is 0, or state WAIT and ack is 1
    assign S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == WAIT && ack == 1));

    // S1_next is 1 when in state S and d is 1
    assign S1_next = (state == S && d == 1);

    // Count_next is 1 when in state B3, or state COUNT and done_counting is 0
    assign Count_next = ((state == B3) || (state == COUNT && done_counting == 0));

    // Wait_next is 1 when in state COUNT and done_counting is 1, or state WAIT and ack is 0
    assign Wait_next = ((state == COUNT && done_counting == 1) || (state == WAIT && ack == 0));
    
endmodule
