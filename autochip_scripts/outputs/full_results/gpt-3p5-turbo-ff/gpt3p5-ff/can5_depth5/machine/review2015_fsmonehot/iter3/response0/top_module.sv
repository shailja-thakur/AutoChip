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

    // State declarations
    localparam S = 10'b0000000001;   // State S
    localparam S1 = 10'b0000000010;  // State S1
    localparam S11 = 10'b0000110100; // State S11
    localparam S110 = 10'b0000111000; // State S110
    localparam B0 = 10'b0000111100;  // State B0
    localparam B1 = 10'b0000111110;  // State B1
    localparam B2 = 10'b0000111111;  // State B2
    localparam B3 = 10'b0000011111;  // State B3
    localparam Count = 10'b0000010000;  // State Count
    localparam Wait = 10'b0000110101;  // State Wait

    // State transitions
    always @(state or d or done_counting or ack) begin
        B3_next = (state == B2) ? 1'b1 : 1'b0;
        S_next = ((state == S && d == 1'b0) || (state == S1 && d == 1'b0) || (state == S110 && d == 1'b0) || (state == Wait && ack == 1'b1)) ? 1'b1 : 1'b0;
        S1_next = (state == S && d == 1'b1) ? 1'b1 : 1'b0;
        Count_next = (state == B3 || (state == Count && done_counting == 1'b0)) ? 1'b1 : 1'b0;
        Wait_next = (state == Count && done_counting == 1'b1) || (state == Wait && ack == 1'b0) ? 1'b1 : 1'b0;
    end

    // Output assignments
    always @* begin
        shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
        done = (state == Wait) ? 1'b1 : 1'b0;
        counting = (state == Count) ? 1'b1 : 1'b0;
    end

endmodule
