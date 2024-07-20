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
    
    // Assignments for done and counting signals
    assign done = state[9]; // Wait state
    assign counting = state[8]; // Count state
    
    // Assignments for shift_ena signal
    assign shift_ena = state[7] | state[6] | state[5] | state[4]; // B3, B2, B1, B0 states
    
    // Assignments for B3_next signal
    assign B3_next = state[6]; // B2 state
    
    // Assignments for S_next signal
    assign S_next = (state[0] & ~d) | (state[1] & ~d) | (state[3] & ~d) | (state[9] & ack); // S, S1, S110, Wait states
    
    // Assignments for S1_next signal
    assign S1_next = state[0] & d; // S state
    
    // Assignments for Count_next signal
    assign Count_next = state[7] | (state[8] & ~done_counting); // B3, Count states
    
    // Assignments for Wait_next signal
    assign Wait_next = (state[8] & done_counting) | (state[9] & ~ack); // Count, Wait states

endmodule
