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
 assign B3_next = (state == 10'b0000000001);
 assign S_next = (state == 10'b0000000010);
 assign S1_next = (state == 10'b0000000100);
 assign Count_next = (state == 10'b1000000000);
 assign Wait_next = (state == 10'b0100000000);

 // Output logic
 assign done = (state == 10'b1000000000);
 assign counting = (state == 10'b1000000000 || state == 10'b0100000000);
 assign shift_ena = (state >= 10'b1111111000 && state <= 10'b1111111111);

endmodule
