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

always @(state) begin

    // State transition logic for B3
    if(state == 10'b0111111111)
        B3_next = 1'b1;
    else
        B3_next = 1'b0;

    // State transition logic for S
    S_next = ~d;

    // State transition logic for S1
    if(state[0] && d)
        S1_next = 1'b1;
    else
        S1_next = 1'b0;

    // State transition logic for Count
    if(state[9] && done_counting)
        Count_next = 1'b1;
    else
        Count_next = 1'b0;

    // State transition logic for Wait
    if(state[9] && done_counting && ~ack)
        Wait_next = 1'b1;
    else
        Wait_next = 1'b0;

end

always @(state) begin

    // Output logic
    done = state[9] && done_counting && ack;
    counting = state[9] && done_counting;
    shift_ena = state >= 10'b0111111111;

end

endmodule
