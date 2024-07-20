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
assign B3_next = state[0] ? 1'b0 : 1'b1;
assign S_next = d ? S_next : state[0];
assign S1_next = d ? S11_next : state[0];
assign Count_next = done_counting ? Wait_next : Count_next;
assign Wait_next = ack ? S_next : Wait_next;

// Output logic
assign done = Wait_next;
assign counting = state[3];
assign shift_ena = state[6];

endmodule
