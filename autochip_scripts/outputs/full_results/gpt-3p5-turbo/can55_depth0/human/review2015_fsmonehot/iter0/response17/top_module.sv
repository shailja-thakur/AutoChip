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
    assign B3_next = state[3] && shift_ena;    // B3_next is high when current state is B3 and shift_ena is high
    assign S_next = state[0] && (~d);    // S_next is high when current state is S and d is low
    assign S1_next = state[1] && (~d);    // S1_next is high when current state is S1 and d is low
    assign Count_next = state[8] && counting && (~done_counting);    // Count_next is high when current state is Count, counting is high, and done_counting is low
    assign Wait_next = state[9] && done && (~ack);    // Wait_next is high when current state is Wait, done is high, and ack is low
    
    // Output logic
    assign done = state[9];    // done is high when current state is Wait
    assign counting = state[8];    // counting is high when current state is Count
    assign shift_ena = state[5:2] == 4'b0110 || state[5:2] == 4'b0111;    // shift_ena is high when current state is B0, B1, B2, or B3
    
endmodule
