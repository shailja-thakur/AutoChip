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
    assign S_next = (state == 10'b0000000001) ? d : 1'b0;
    assign S1_next = (state == 10'b0000000010) ? d : (state == 10'b0000000011) ? d : 1'b0;
    assign Count_next = (state == 10'b1000000000) ? 1'b1 : (state == 10'b0000000100) ? 1'b1 : 1'b0;
    assign Wait_next = (state == 10'b1000000000) ? 1'b0 : (state == 10'b1000000001) ? 1'b1 : 1'b0;
    assign B3_next = (state == 10'b1000000011) ? 1'b1 : 1'b0;

    // Output logic
    assign done = (state == 10'b0100000000) ? 1'b1 : 1'b0;
    assign counting = (state == 10'b1000000000) ? 1'b1 : 1'b0;
    assign shift_ena = (state == 10'b1000000011 || state >= 10'b1000000100) ? 1'b1 : 1'b0;

endmodule
