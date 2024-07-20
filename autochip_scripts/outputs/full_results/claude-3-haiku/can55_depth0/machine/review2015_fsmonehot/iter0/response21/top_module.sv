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

// Decode the current state
wire s = state[0];
wire s1 = state[1];
wire s11 = state[2];
wire s110 = state[3];
wire b0 = state[4];
wire b1 = state[5];
wire b2 = state[6];
wire b3 = state[7];
wire count = state[8];
wire wait_state = state[9];

// Assign the output signals
assign done = wait_state;
assign counting = count;
assign shift_ena = b3 | b2 | b1 | b0;

// Assign the next state signals
assign B3_next = b2;
assign S_next = (s & ~d) | (s1 & ~d) | (s110 & ~d) | (wait_state & ack);
assign S1_next = s & d;
assign Count_next = (b3) | (count & ~done_counting);
assign Wait_next = (count & done_counting) | (wait_state & ~ack);

endmodule
