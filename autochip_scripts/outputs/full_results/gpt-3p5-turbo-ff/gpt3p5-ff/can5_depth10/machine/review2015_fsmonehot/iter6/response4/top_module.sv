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

    reg [9:0] next_state;
    
    // Assign next_state
    always @(*)
    begin
        case(state)
            S: next_state = d ? S1 : S;
            S1: next_state = ~d ? S : S11;
            S11: next_state = d ? S110 : S11;
            S110: next_state = ack ? Wait : B0;
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = B3;
            Count: next_state = done_counting ? Wait : Count;
            Wait: next_state = ack ? Count : Wait;
            default: next_state = S;
        endcase
    end

    // Assign next state signals
    always @(*)
    begin
        B3_next = (next_state == B3);
        S_next = ((next_state == S) & (~d)) | ((next_state == S1) & (~d)) | ((next_state == S110) & (~d)) | ((next_state == Wait) & ack);
        S1_next = (next_state == S) & (d);
        Count_next = (next_state == B3) | ((next_state == Count) & (~done_counting));
        Wait_next = ((next_state == Count) & done_counting) | ((next_state == Wait) & (~ack));
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
        shift_ena = (state == B3) | (state == B2) | (state == B1) | (state == B0);
    end

endmodule
