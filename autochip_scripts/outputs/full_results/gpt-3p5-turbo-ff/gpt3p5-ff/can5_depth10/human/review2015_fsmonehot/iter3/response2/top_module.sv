module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

    wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    
    assign S = state[0];
    assign S1 = state[1];
    assign S11 = state[2];
    assign S110 = state[3];
    assign B0 = state[4];
    assign B1 = state[5];
    assign B2 = state[6];
    assign B3 = state[7];
    assign Count = state[8];
    assign Wait = state[9];
    
    assign B3_next = B2;
    
    assign S_next = (S && !d) || (S1 && d) || (S11 && !d && !S110) || (S110 && d);
    assign S1_next = (S11 && !d && !S110) || (S11 && d) || (S1 && !d);
    assign Count_next = (Count && !done_counting) || (!Count && done_counting);
    assign Wait_next = (Wait && !done) || (Wait && ack) || (Count && done_counting);
    
    assign done = (Wait && !ack);
    
    assign counting = Count || (!B0 && !B1 && !B2 && !B3);
    
    assign shift_ena = B0 || B1 || B2 || B3;
    
endmodule
