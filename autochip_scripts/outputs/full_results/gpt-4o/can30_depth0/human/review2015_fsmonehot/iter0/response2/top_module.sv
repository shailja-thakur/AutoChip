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

    // State encodings
    localparam S        = 10'b0000000001;
    localparam S1       = 10'b0000000010;
    localparam S11      = 10'b0000000100;
    localparam S110     = 10'b0000001000;
    localparam B0       = 10'b0000010000;
    localparam B1       = 10'b0000100000;
    localparam B2       = 10'b0001000000;
    localparam B3       = 10'b0010000000;
    localparam Count    = 10'b0100000000;
    localparam Wait     = 10'b1000000000;
    
    wire state_S     = state[0];
    wire state_S1    = state[1];
    wire state_S11   = state[2];
    wire state_S110  = state[3];
    wire state_B0    = state[4];
    wire state_B1    = state[5];
    wire state_B2    = state[6];
    wire state_B3    = state[7];
    wire state_Count = state[8];
    wire state_Wait  = state[9];

    // Next state logic
    assign S_next    = state_S & !d | state_S1 & !d | state_S110 & !d | state_Wait & ack;
    assign S1_next   = state_S & d | state_S11 & d;
    assign S11_next  = state_S1 & d | state_S11 & d;
    assign S110_next = state_S11 & !d;
    assign B0_next   = state_S110 & d;
    assign B1_next   = state_B0;
    assign B2_next   = state_B1;
    assign B3_next   = state_B2;
    assign Count_next= state_B3;
    assign Wait_next = state_Count & done_counting | state_Wait & !ack;

    // Output logic
    assign shift_ena = state_B0 | state_B1 | state_B2 | state_B3;
    assign counting  = state_Count;
    assign done      = state_Wait;

endmodule
