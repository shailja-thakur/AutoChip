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

    parameter S = 0, S1 = 1, S11 = 2, S110 = 3, B0 = 4, B1 = 5, B2 = 6, B3 = 7, Count = 8, Wait = 9;

    always @(*) begin
        // Default values
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;

        if (state[Wait]) begin
            done = 1;
        end

        if (state[Count]) begin
            counting = 1;
        end

        if (state[B3] || state[B2] || state[B1] || state[B0]) begin
            shift_ena = 1;
        end

        if (state[B2]) begin
            B3_next = 1;
        end

        if ((state[S] && d == 0) ||
            (state[S1] && d == 0) ||
            (state[S110] && d == 0) ||
            (state[Wait] && ack == 1)) begin
            S_next = 1;
        end

        if (state[S] && d == 1) begin
            S1_next = 1;
        end

        if (state[B3] || (state[Count] && done_counting == 0)) begin
            Count_next = 1;
        end
        
        if ((state[Count] && done_counting == 1) ||
            (state[Wait] && ack == 0)) begin
            Wait_next = 1;
        end
    end
endmodule
