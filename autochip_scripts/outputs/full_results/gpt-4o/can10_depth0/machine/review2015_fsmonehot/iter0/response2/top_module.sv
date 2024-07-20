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
    
    // State definitions
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

    // Internal signals
    wire state_S      = state[0];
    wire state_S1     = state[1];
    wire state_S11    = state[2];
    wire state_S110   = state[3];
    wire state_B0     = state[4];
    wire state_B1     = state[5];
    wire state_B2     = state[6];
    wire state_B3     = state[7];
    wire state_Count  = state[8];
    wire state_Wait   = state[9];

    // Output logic
    assign B3_next = state_B2;
    assign S_next = (state_S && ~d) || (state_S1 && ~d) || (state_S110 && ~d) || (state_Wait && ack);
    assign S1_next = state_S && d;
    assign Count_next = state_B3 || (state_Count && ~done_counting);
    assign Wait_next = (state_Count && done_counting) || (state_Wait && ~ack);
    assign done = state_Wait;
    assign counting = state_Count;
    assign shift_ena = state_B0 || state_B1 || state_B2 || state_B3;

endmodule
