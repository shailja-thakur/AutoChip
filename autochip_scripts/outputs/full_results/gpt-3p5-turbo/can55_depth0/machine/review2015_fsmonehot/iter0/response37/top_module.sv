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

    // Define all the states
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

    always @* begin
        
        // Determine value of shift_ena signal
        shift_ena = (state & {B3, B2, B1, B0}) ? 1'b1 : 1'b0;
        
        // Determine value of B3_next output
        B3_next = (state == B2) ? 1'b1 : 1'b0;
        
        // Determine value of S_next output
        S_next = ((state == S && d == 1'b0) || (state == S1 && d == 1'b0) || (state == S110 && d == 1'b0) || (state == Wait && ack == 1'b1)) ? 1'b1 : 1'b0;
        
        // Determine value of S1_next output
        S1_next = (state == S && d == 1'b1) ? 1'b1 : 1'b0;
        
        // Determine value of Count_next output
        Count_next = (state == B3 || (state == Count && done_counting == 1'b0)) ? 1'b1 : 1'b0;
        
        // Determine value of Wait_next output
        Wait_next = (state == Count && done_counting == 1'b1) || (state == Wait && ack == 1'b0)) ? 1'b1 : 1'b0;
        
    end

    // Define the outputs done and counting
    assign done = (state == Wait) ? 1'b1 : 1'b0;
    assign counting = (state == Count) ? 1'b1 : 1'b0;

endmodule
