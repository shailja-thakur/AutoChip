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

    // Define the states
    parameter S = 10'b0000000001;
    parameter S1 = 10'b0000000010;
    parameter S11 = 10'b0000000100;
    parameter S110 = 10'b0000001000;
    parameter B0 = 10'b0000010000;
    parameter B1 = 10'b0000100000;
    parameter B2 = 10'b0001000000;
    parameter B3 = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait = 10'b1000000000;

    always @*
    begin
        done = (state == Wait) ? 1 : 0;
        counting = (state == Count) ? 1 : 0;
        shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1 : 0;
        B3_next = (state == B2) ? 1 : 0;
        S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1)) ? 1 : 0;
        S1_next = (state == S && d == 1) ? 1 : 0;
        Count_next = (state == B3 || (state == Count && done_counting == 0)) ? 1 : 0;
        Wait_next = ((state == Count && done_counting == 1) || (state == Wait && ack == 0)) ? 1 : 0;
    end
    
endmodule
