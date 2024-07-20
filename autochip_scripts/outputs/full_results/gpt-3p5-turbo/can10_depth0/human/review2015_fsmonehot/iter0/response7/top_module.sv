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

    wire [9:0] state;
    assign state = {S_next, S1_next, S11_next, S110_next, B0_next, B1_next, B2_next, B3_next, Count_next, Wait_next};

    // B3_next
    assign B3_next = state[3] && ack; 

    // S_next
    assign S_next = (~d) && (~state[3]) && (~state[2]);

    // S1_next
    assign S1_next = d && (~state[3]) && (~state[2]);

    // Count_next
    assign Count_next = state[7] && (~done_counting);

    // Wait_next
    assign Wait_next = state[8] && done;

    // done
    assign done = state[8] && (~ack);

    // counting
    assign counting = state[8];

    // shift_ena
    assign shift_ena = state[9];

endmodule
