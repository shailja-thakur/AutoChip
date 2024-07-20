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

    // State assignments based on one-hot encoding
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

    wire is_S     = state[0];
    wire is_S1    = state[1];
    wire is_S11   = state[2];
    wire is_S110  = state[3];
    wire is_B0    = state[4];
    wire is_B1    = state[5];
    wire is_B2    = state[6];
    wire is_B3    = state[7];
    wire is_Count = state[8];
    wire is_Wait  = state[9];

    // Next state logic
    assign S_next     = (is_S && !d) || (is_S1 && !d) || (is_S110 && !d) || (is_Wait && ack);
    assign S1_next    = is_S && d;
    assign S11_next   = is_S1 && d;
    assign S110_next  = is_S11 && !d;
    assign B0_next    = is_S110 && d;
    assign B1_next    = is_B0;
    assign B2_next    = is_B1;
    assign B3_next    = is_B2;
    assign Count_next = is_B3 || (is_Count && !done_counting);
    assign Wait_next  = is_Count && done_counting;

    // Output logic
    assign shift_ena = is_B0 || is_B1 || is_B2 || is_B3;
    assign counting  = is_Count;
    assign done      = is_Wait;

endmodule
