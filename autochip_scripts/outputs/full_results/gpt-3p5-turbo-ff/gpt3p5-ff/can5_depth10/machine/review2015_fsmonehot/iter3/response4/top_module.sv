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

    // States
    parameter [9:0] S = 10'b0000000001;
    parameter [9:0] S1 = 10'b0000000010;
    parameter [9:0] S11 = 10'b0000000100;
    parameter [9:0] S110 = 10'b0000001000;
    parameter [9:0] B0 = 10'b0000010000;
    parameter [9:0] B1 = 10'b0000100000;
    parameter [9:0] B2 = 10'b0001000000;
    parameter [9:0] B3 = 10'b0010000000;
    parameter [9:0] Count = 10'b0100000000;
    parameter [9:0] Wait = 10'b1000000000;
    
    // Assign next state signals
    always @(*)
    begin
        B3_next = (state == B2);
        S_next = ((state == S & d == 0) | (state == S1 & d == 0) | (state == S110 & d == 0) | (state == Wait & ack == 1));
        S1_next = (state == S & d == 1);
        Count_next = (state == B3 | (state == Count & ~done_counting));
        Wait_next = (state == Count & done_counting) | (state == Wait & ~ack);
    end

    // Assign done and counting signals
    always @(state)
    begin
        done = (state == Wait);
        counting = (state == Count);
    end

    // Assign shift_ena signal
    always @(state)
    begin
        shift_ena = (state == B0 | state == B1 | state == B2 | state == B3);
    end

endmodule
