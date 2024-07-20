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

    wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    
    assign {S, S1, S11, S110, B0, B1, B2, B3, Count, Wait} = state;

    // Next state logic
    assign S_next     = S & ~d | S1 & ~d | S110 & ~d | Wait & ack;
    assign S1_next    = S & d | S1 & d;
    assign S11_next   = S1 & d | S11 & d;
    assign S110_next  = S11 & ~d;
    assign B0_next    = S110 & d;
    assign B1_next    = B0;
    assign B2_next    = B1;
    assign B3_next    = B2;
    assign Count_next = B3 | Count & ~done_counting;
    assign Wait_next  = Count & done_counting | Wait & ~ack;
    
    // Output logic
    assign done       = Wait;
    assign counting   = Count;
    assign shift_ena  = B0 | B1 | B2 | B3;

endmodule
