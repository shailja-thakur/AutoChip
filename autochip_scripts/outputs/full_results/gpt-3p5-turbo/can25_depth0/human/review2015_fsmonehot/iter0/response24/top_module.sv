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

    // State transition logic equations

    assign B3_next = (state == 10'b0111111111); // B3_next is true if current state is B3

    assign S_next = (d == 1'b0) ? state & 10'b1111111110 : state; // S_next is state if d is 0, else S_next is state & 10'b1111111110

    assign S1_next = (d == 1'b0) ? state & 10'b1111111110 : state | 10'b0000000010; // S1_next is state if d is 0, else S1_next is state | 10'b0000000010

    assign Count_next = (state == 10'b1000000000) ? (done_counting == 1'b0) ? state : state & 10'b1111111110 : state; // Count_next is state if current state is Count and done_counting is 0, else Count_next is state & 10'b1111111110

    assign Wait_next = (state == 10'b1000000000) ? (done_counting == 1'b1) ? state | 10'b0000000010 : state : state; // Wait_next is state if current state is Count, else Wait_next is state | 10'b0000000010


    // Output logic equations

    assign done = (state == 10'b1000000000) ? 1'b1 : 1'b0; // done is true if current state is Count

    assign counting = (state == 10'b1000000000) ? 1'b1 : 1'b0; // counting is true if current state is Count

    assign shift_ena = (state >= 10'b0111111111 & state <= 10'b1000000000) ? 1'b1 : 1'b0; // shift_ena is true if current state is between B3 and Count, inclusive

endmodule
