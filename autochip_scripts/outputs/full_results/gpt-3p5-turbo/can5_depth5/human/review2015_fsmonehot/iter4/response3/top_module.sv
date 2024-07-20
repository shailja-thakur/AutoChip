module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

// State transition logic for B3
always @*
begin
    B3_next = (state == 10'b0111111111);
end

// State transition logic for S
always @*
begin
    S_next = ~d;
end

// State transition logic for S1
always @*
begin
    S1_next = d;
end

// State transition logic for Count
always @*
begin
    Count_next = state[9] && done_counting && ~ack;
end

// State transition logic for Wait
always @*
begin
    Wait_next = state[9] && done_counting && ack;
end

// Output logic
always @*
begin
    done = state[9] && done_counting && ack;
    counting = state[9] && done_counting;
    shift_ena = (state[9:0] >= 10'b0111111111);
end

endmodule
