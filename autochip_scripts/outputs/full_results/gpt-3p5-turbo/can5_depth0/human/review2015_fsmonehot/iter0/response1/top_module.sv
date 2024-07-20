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

// Write your logic equations here

// State transition logic
assign B3_next = (state == 10'b0111111111);
assign S_next = (d == 1'b0 && state == 10'b0000000001) || (d == 1'b1 && state == 10'b0000000001) || (d == 1'b1 && state == 10'b0000000010) || (d == 1'b1 && state == 10'b0000000100) || (d == 1'b0 && state == 10'b0000000011) || (d == 1'b1 && state == 10'b0000000011) || (d == 1'b0 && state == 10'b0000000110) || (d == 1'b1 && state == 10'b0000000110);
assign S1_next = (d == 1'b0 && state == 10'b0000000010) || (d == 1'b1 && state == 10'b0000000010) || (d == 1'b0 && state == 10'b0000000110) || (d == 1'b1 && state == 10'b0000000110) || (d == 1'b1 && state == 10'b0000001000);
assign Count_next = (state == 10'b1000000000) || (state == 10'b1000000001);
assign Wait_next = (state == 10'b1000000001) || (state == 10'b1000000010);

// Output logic
assign done = (state == 10'b1000000010);
assign counting = (state == 10'b1000000000) || (state == 10'b1000000001) || (state == 10'b1000000010);
assign shift_ena = (state >= 10'b0111111110 && state <= 10'b0111111111);

endmodule
