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
assign S_next = (state == 10'b0000000001) ? (d ? 10'b0000000010 : 10'b0000000001) : 10'b0000000001;
assign S1_next = (state == 10'b0000000010) ? (d ? 10'b0000000100 : 10'b0000000011) : 10'b0000000010;
assign Count_next = (state == 10'b1000000000 || (state >= 10'b0000000100 && state <= 10'b0111111111)) && counting && !done_counting ? 10'b1000000000 : 10'b0000000000;
assign Wait_next = (state == 10'b1000000000 || (state >= 10'b0000000100 && state <= 10'b0111111111)) && counting && done_counting ? 10'b0000000100 : (state == 10'b0000000100 && done) ? 10'b0000000101 : 10'b0000000100;
assign B3_next = (state == 10'b0000000100) ? (shift_ena ? 10'b0000000101 : 10'b0000000110) : 10'b0000000100;

// Output logic
assign done = (state == 10'b0000000101) && (!done_counting || !ack);
assign counting = (state >= 10'b0000000100 && state <= 10'b0111111111);
assign shift_ena = (state >= 10'b0000000100 && state <= 10'b0111111111);

endmodule
