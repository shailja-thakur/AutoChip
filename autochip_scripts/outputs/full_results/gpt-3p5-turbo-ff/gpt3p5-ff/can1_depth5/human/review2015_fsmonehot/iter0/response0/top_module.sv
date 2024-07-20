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
 
 // Next state logic
 assign B3_next = (state[3] && shift_ena) ? 1'b1 : 1'b0;
 assign S_next = (state[0] && !d) ? 1'b1 : 1'b0;
 assign S1_next = (state[1] && !d) ? 1'b1 : 1'b0;
 assign Count_next = (state[8] && counting && !done_counting) ? 1'b1 : 1'b0;
 assign Wait_next = (state[9] && done && !ack) ? 1'b1 : 1'b0;
 
 // Output logic
 assign done = state[9];
 assign counting = state[8];
 assign shift_ena = (state[7:4] == 4'b0001) ? 1'b1 : 1'b0;
  
endmodule
