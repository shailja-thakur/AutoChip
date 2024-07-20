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
    
    // declare internal signals
    wire B2_active;
    wire S_active;
    wire S1_active;
    wire S110_active;
    wire B3_active;
    wire Count_active;
    wire Wait_active;
    
    // assign active signals based on the current state
    assign S_active = (state[0] && !d) || (state[2] && !d) || (state[3] && !d) || (state[8] && ack);
    assign S1_active = state[1] && d;
    assign S110_active = state[4] || state[6];
    assign B3_active = state[7];
    assign Count_active = state[7] || (state[5] && !done_counting);
    assign Wait_active = state[9] && ack;
    
    // assign output signals based on the active signals
    assign B3_next = B2_active;
    assign S_next = S_active;
    assign S1_next = S1_active;
    assign Count_next = Count_active;
    assign Wait_next = Wait_active;
    assign done = Wait_active;
    assign counting = Count_active;
    assign shift_ena = B2_active || B1_active || B0_active || B3_active;
    
endmodule
