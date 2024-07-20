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

    // Define the states as parameters
    parameter [9:0] S = 10'b0000000001;    // S state
    parameter [9:0] S1 = 10'b0000000010;   // S1 state
    parameter [9:0] S11 = 10'b0000000011;  // S11 state
    parameter [9:0] S110 = 10'b0000000100; // S110 state
    parameter [9:0] B0 = 10'b0000001000;   // B0 state
    parameter [9:0] B1 = 10'b0000010000;   // B1 state
    parameter [9:0] B2 = 10'b0000100000;   // B2 state
    parameter [9:0] B3 = 10'b0001000000;   // B3 state
    parameter [9:0] Count = 10'b0010000000;   // Count state
    parameter [9:0] Wait = 10'b0100000000;    // Wait state
    
    // Assign default values to the output signals
    always @* begin
        done = (state == Wait) ? 1'b1 : 1'b0;
        counting = (state == Count) ? 1'b1 : 1'b0;
        shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
        B3_next = (state == B2) ? 1'b1 : 1'b0;
        S_next = (state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1) ? 1'b1 : 1'b0;
        S1_next = (state == S && d == 1) ? 1'b1 : 1'b0;
        Count_next = (state == B3) || (state == Count && done_counting == 0) ? 1'b1 : 1'b0;
        Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0) ? 1'b1 : 1'b0;
    end

 endmodule
