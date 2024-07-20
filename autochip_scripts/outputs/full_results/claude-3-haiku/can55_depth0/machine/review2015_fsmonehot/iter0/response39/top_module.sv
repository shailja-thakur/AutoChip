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

wire S         = state[0];
wire S1        = state[1];
wire S11       = state[2];
wire S110      = state[3];
wire B0        = state[4];
wire B1        = state[5];
wire B2        = state[6];
wire B3        = state[7];
wire Count     = state[8];
wire Wait      = state[9];

// The done signal is 1 in the state Wait
assign done = Wait;

// The counting signal is 1 in the state Count
assign counting = Count;

// The shift_ena signal is 1 if any of the states B3, B2, B1 and B0 is active
assign shift_ena = B3 | B2 | B1 | B0;

// The output of the top module B3_next is 1 when the state B2 is active
assign B3_next = B2;

// The output of the top module S_next is 1 when the state S and d is 0, or the state S1 and d is 0, or the state S110 and d is 0, or the state Wait and ack is 1
assign S_next = (S & ~d) | (S1 & ~d) | (S110 & ~d) | (Wait & ack);

// The output of the top module S1_next is 1 when the state S and d is 1
assign S1_next = S & d;

// The output of the top module Count_next is 1 when the state B3 is active, or the state Count and done_counting is 0
assign Count_next = B3 | (Count & ~done_counting);

// The output of the top module Wait_next is 1 when the state Count and done_counting is 1, or the state Wait and ack is 0
assign Wait_next = (Count & done_counting) | (Wait & ~ack);

endmodule
