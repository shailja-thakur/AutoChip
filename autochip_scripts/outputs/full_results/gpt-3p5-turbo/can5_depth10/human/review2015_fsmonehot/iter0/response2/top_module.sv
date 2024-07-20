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

    // State transition logic
    assign B3_next = state[3] & shift_ena;   // B3_next is high if the current state is B3 and shift_ena is high
    assign S_next = state[1] & !d;           // S_next is high if the current state is S and d is low
    assign S1_next = state[2] & d;           // S1_next is high if the current state is S1 and d is high
    assign Count_next = state[8] & counting;  // Count_next is high if the current state is Count and counting is high
    assign Wait_next = state[9] & done;       // Wait_next is high if the current state is Wait and done is high

    // Output logic
    assign done = state[9] & !ack;            // done is high if the current state is Wait and ack is low
    assign counting = state[8];               // counting always follows the 8th bit of the state
    assign shift_ena = state[5:2] == 4'b0101; // shift_ena is high if the 5th, 4th, 3rd, and 2nd bits of the state are 0101

endmodule
