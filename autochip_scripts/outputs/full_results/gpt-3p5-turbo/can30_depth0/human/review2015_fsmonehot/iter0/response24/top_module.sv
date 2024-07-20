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

// Derive state transition logic for state B3
assign B3_next = (state[9] && shift_ena) ? 1'b1 : 1'b0;

// Derive state transition logic for state S
assign S_next = (d == 1'b0 && state[0]) ? 1'b1 : 1'b0;

// Derive state transition logic for state S1
assign S1_next = (d == 1'b1 && state[1]) ? 1'b1 : 1'b0;

// Derive state transition logic for state Count
assign Count_next = (counting && done_counting) ? 1'b1 : 1'b0;

// Derive state transition logic for state Wait
assign Wait_next = (done && ack) ? 1'b1 : 1'b0;

// Derive output logic for done
assign done = (state[8] == 1'b1) ? 1'b1 : 1'b0;

// Derive output logic for counting
assign counting = (state[7] == 1'b1) ? 1'b1 : 1'b0;

// Derive output logic for shift_ena
assign shift_ena = (state[6] == 1'b1) ? 1'b1 : 1'b0;

endmodule
