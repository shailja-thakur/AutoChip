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

// State transition logic for B3
assign B3_next = (state == 10'b0111111111);

// State transition logic for S
assign S_next = (state == 10'b0000000001 && !d) || (state == 10'b0000000000 && d);

// State transition logic for S1
assign S1_next = (state == 10'b0000000010 && !d) || (state == 10'b0000000001 && d);

// State transition logic for Count
assign Count_next = (state == 10'b1000000000 && !done_counting) || (state == 10'b1000000000 && done_counting);

// State transition logic for Wait
assign Wait_next = (state == 10'b1000000000 && done_counting && !ack) || (state == 10'b1000000000 && done_counting && ack);

// Output logic
assign done = (state == 10'b1000000000 && done_counting && ack);
assign counting = (state == 10'b1000000000);
assign shift_ena = (state >= 10'b0111111111);

endmodule
