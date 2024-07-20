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

// Assign outputs
assign shift_ena = (state[B3] | state[B2] | state[B1] | state[B0]);
assign done = (state == state[Wait]);
assign counting = (state == state[Count]);

// State transitions

always @ (posedge clk)
begin
    B3_next = (state == state[B2]);
    S_next = ((state == state[S] && !d) || (state == state[S1] && !d) || (state == state[S110] && !d) || (state == state[Wait] && ack));
    S1_next = (state == state[S] && d);
    Count_next = (state == state[B3] || (state == state[Count] && !done_counting));
    Wait_next = ((state == state[Count] && done_counting) || (state == state[Wait] && !ack));
end

endmodule
