module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

// State encoding
parameter S     = 10'b0000000001;
parameter S1    = 10'b0000000010;
parameter S11   = 10'b0000000100;
parameter S110  = 10'b0000001000;
parameter B0    = 10'b0000010000;
parameter B1    = 10'b0000100000;
parameter B2    = 10'b0001000000;
parameter B3    = 10'b0010000000;
parameter Count = 10'b0100000000;
parameter Wait  = 10'b1000000000;

// Next state logic
always @(*) begin
    S_next = state[S] & ~d | state[S1] & ~d | state[S110] & ~d | state[Wait] & ack;
    S1_next = state[S] & d | state[S11] & d;
    B3_next = state[B2];
    Count_next = state[B3];
    Wait_next = state[Count] & done_counting | state[Wait] & ~ack;

    // Output logic
    shift_ena = state[B0] | state[B1] | state[B2] | state[B3];
    counting = state[Count];
    done = state[Wait];
end

endmodule
