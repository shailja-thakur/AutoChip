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

    // State Encoding
    localparam STATE_S     = 10'b0000000001;
    localparam STATE_S1    = 10'b0000000010;
    localparam STATE_S11   = 10'b0000000100;
    localparam STATE_S110  = 10'b0000001000;
    localparam STATE_B0    = 10'b0000010000;
    localparam STATE_B1    = 10'b0000100000;
    localparam STATE_B2    = 10'b0001000000;
    localparam STATE_B3    = 10'b0010000000;
    localparam STATE_COUNT = 10'b0100000000;
    localparam STATE_WAIT  = 10'b1000000000;
    
    wire S     = state[0];
    wire S1    = state[1];
    wire S11   = state[2];
    wire S110  = state[3];
    wire B0    = state[4];
    wire B1    = state[5];
    wire B2    = state[6];
    wire B3    = state[7];
    wire Count = state[8];
    wire Wait  = state[9];
    
    // Next-State Logic
    assign S_next     = (S & ~d) | (S1 & ~d) | (S110 & ~d) | (Wait & ack);
    assign S1_next    = (S & d);
    assign S11_next   = (S1 & d) | (S11 & d);
    assign S110_next  = (S11 & ~d);
    assign B0_next    = (S110 & d);
    assign B1_next    = B0;
    assign B2_next    = B1;
    assign B3_next    = B2;
    assign Count_next = B3;
    assign Wait_next  = Count & done_counting | (Wait & ~ack);
    
    // Output Logic
    assign shift_ena = B0 | B1 | B2 | B3;
    assign counting  = Count & ~done_counting;
    assign done      = Wait;
    
endmodule
