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

    wire B3_next;
    wire S_next;
    wire S1_next;
    wire Count_next;
    wire Wait_next;
    wire done;
    wire counting;
    wire shift_ena;
    
    assign B3_next = state[9];
    assign S_next = (state[0]) ? d : state[0];
    assign S1_next = (state[1]) ? S_next : (state[1] && d);
    assign Count_next = (state[7]) ? ((state[8]) ? Wait_next : Count_next) : state[7];
    assign Wait_next = ack ? S_next : state[9];

    assign done = state[8];
    assign counting = state[7];
    assign shift_ena = (state[6] && ~state[7]);
    
endmodule
