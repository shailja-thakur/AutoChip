module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
 );

    assign B3_next = state[6]; 
    
    assign S_next = (state[0] && !d) || (state[1] && d) || (state[2] && !d && !state[3]) || (state[3] && d && !state[2]);
    assign S1_next = (state[2] && d && !state[3]);
    assign Count_next = (state[7] && !done_counting) || (state[8] && done_counting);
    assign Wait_next = (state[9] && !ack && !done) || (state[9] && ack);
    
    assign done = state[9] && !ack;
    
    assign counting = state[8] || (!state[4] && !state[5] && !state[6] && !state[7]);
    
    assign shift_ena = state[4] || state[5] || state[6] || state[7];
    
endmodule
