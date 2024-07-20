module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg S110_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

    // Next-state logic
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        S110_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        if (state[0] && ~d)
            S_next = 1'b1;
        else if (state[1] && ~d)
            S_next = 1'b1;
        else if (state[1] && d)
            S1_next = 1'b1;
        else if (state[2] && ~d)
            S_next = 1'b1;
        else if (state[2] && d)
            S11_next = 1'b1;
        else if (state[3] && ~d)
            S110_next = 1'b1;
        else if (state[3] && d)
            B0_next = 1'b1;
        else if (state[4])
            B1_next = 1'b1;
        else if (state[5])
            B2_next = 1'b1;
        else if (state[6])
            B3_next = 1'b1;
        else if (state[7] && ~done_counting)
            Count_next = 1'b1;
        else if (state[7] && done_counting)
            Wait_next = 1'b1;
        else if (state[8] && ~ack)
            Wait_next = 1'b1;
        else if (state[8] && ack)
            S_next = 1'b1;
    end

    // Output logic
    always @(*) begin
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        if (state[8])
            done = 1'b1;
        if (state[7])
            counting = 1'b1;
        if (state[4] || state[5] || state[6])
            shift_ena = 1'b1;
    end

endmodule
