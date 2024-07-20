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
    output done,
    output counting,
    output shift_ena
 );
 
 // Declare the states
 reg [9:0] S;
 reg [9:0] S1;
 reg [9:0] S11;
 reg [9:0] S110;
 reg [9:0] B0;
 reg [9:0] B1;
 reg [9:0] B2;
 reg [9:0] B3;
 reg [9:0] Count;
 reg [9:0] Wait;
 
 // Assign the states according to their one-hot values
 always @*
 begin
    S = 10'b0000000001;
    S1 = 10'b0000000010;
    S11 = 10'b0000000110;
    S110 = 10'b0000011110;
    B0 = 10'b0000100000;
    B1 = 10'b0001000000;
    B2 = 10'b0010000000;
    B3 = 10'b0100000000;
    Count = 10'b1000000000;
    Wait = 10'b0000010000;
 end
 
 // Assign the outputs based on the current state and input signals
 always @(state, d, ack, done_counting)
 begin
    // Assign B3_next output
    if (state == B2)
        B3_next = 1'b1;
    else
        B3_next = 1'b0;
        
    // Assign S_next output
    if ((state == S && d == 1'b0) ||
        (state == S1 && d == 1'b0) ||
        (state == S110 && d == 1'b0) ||
        (state == Wait && ack == 1'b1))
        S_next = 1'b1;
    else
        S_next = 1'b0;
        
    // Assign S1_next output
    if (state == S && d == 1'b1)
        S1_next = 1'b1;
    else
        S1_next = 1'b0;
        
    // Assign Count_next output
    if (state == B3 || (state == Count && done_counting == 1'b0))
        Count_next = 1'b1;
    else
        Count_next = 1'b0;
        
    // Assign Wait_next output
    if ((state == Count && done_counting == 1'b1) ||
        (state == Wait && ack == 1'b0))
        Wait_next = 1'b1;
    else
        Wait_next = 1'b0;
        
    // Assign done output
    if (state == Wait)
        done = 1'b1;
    else
        done = 1'b0;
        
    // Assign counting output
    if (state == Count)
        counting = 1'b1;
    else
        counting = 1'b0;
        
    // Assign shift_ena output
    if (state == B3 || state == B2 || state == B1 || state == B0)
        shift_ena = 1'b1;
    else
        shift_ena = 1'b0;
 end
endmodule
