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

wire s_state, s1_state, s110_state, b0_state, b1_state, b2_state, b3_state, count_state, wait_state;

assign s_state      = state[0];
assign s1_state     = state[1];
assign s110_state   = state[2];
assign b0_state     = state[3];
assign b1_state     = state[4];
assign b2_state     = state[5];
assign b3_state     = state[6];
assign count_state  = state[7];
assign wait_state   = state[8];

assign B3_next = b2_state;
assign S_next  = (s_state && !d) || (s1_state && !d) || (s110_state && !d) || (wait_state && ack);
assign S1_next = s_state && d;
assign Count_next = (b3_state) || (count_state && !done_counting);
assign Wait_next = (count_state && done_counting) || (wait_state && !ack);

assign done = wait_state;
assign counting = count_state;
assign shift_ena = b0_state || b1_state || b2_state || b3_state;

endmodule
