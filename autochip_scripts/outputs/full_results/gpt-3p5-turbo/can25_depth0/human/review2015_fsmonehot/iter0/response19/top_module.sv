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

    // Assigning next-state logic
    assign B3_next = state[9] & state[8] & state[7]; // B3_next = B0 & B1 & B2

    assign S_next = state[0] & ~d & ~state[1]; // S_next = S & ~d & ~S1

    assign S1_next = state[1] & ~d & ~state[2]; // S1_next = S1 & ~d & ~S11

    assign Count_next = state[7] & ~done_counting & ~state[8]; // Count_next = B3 & ~done_counting & ~Count

    assign Wait_next = state[8] & done & ~state[9]; // Wait_next = Count & done & ~Wait

    // Assigning output logic
    assign done = state[9] & ~ack; // done = Wait & ~ack

    assign counting = state[6] | state[7] | state[8] | state[9]; // counting = B2 | B3 | Count | Wait

    assign shift_ena = state[7] | state[8] | state[9]; // shift_ena = B2 | B3 | Count

endmodule
