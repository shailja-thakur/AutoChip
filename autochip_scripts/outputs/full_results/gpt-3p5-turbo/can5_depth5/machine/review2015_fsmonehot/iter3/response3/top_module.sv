module top_module(
    input wire d,
    input wire done_counting,
    input wire ack,
    input wire [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
);

// State definitions
localparam S = 10'b0000000001;
localparam S1 = 10'b0000000010;
localparam S11 = 10'b0000000100;
localparam S110 = 10'b0000001000;
localparam B0 = 10'b0000010000;
localparam B1 = 10'b0000100000;
localparam B2 = 10'b0001000000;
localparam B3 = 10'b0010000000;
localparam Count = 10'b0100000000;
localparam Wait = 10'b1000000000;

// State logic and next state assignments
always @* begin
    B3_next = (state[6]);
    S_next = ((state[9] && !d) || (state[8] && !d) || (state[3] && !d) || (state[0] && ack));
    S1_next = (state[9] && d);
    Count_next = (state[6] || (state[5] && !done_counting));
    Wait_next = (state[5] && done_counting) || (state[4] && !ack);
end

// Output assignments
always @* begin
    done = state[4];
    counting = state[5];
    shift_ena = (state[6] || state[7] || state[8] || state[9]);
end

endmodule
