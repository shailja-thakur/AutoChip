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

    // Next-state logic
    always @(*) begin
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;

        case (1'b1)
            state[0]: // S
                if (d)
                    S1_next = 1;
                else
                    S_next = 1;
            state[1]: // S1
                if (d)
                    S11_next = 1;
                else
                    S_next = 1;
            state[2]: // S11
                if (d)
                    S11_next = 1;
                else
                    S110_next = 1;
            state[3]: // S110
                if (d)
                    B0_next = 1;
                else
                    S_next = 1;
            state[4]: // B0
                B1_next = 1;
            state[5]: // B1
                B2_next = 1;
            state[6]: // B2
                B3_next = 1;
            state[7]: // B3
                Count_next = 1;
            state[8]: // Count
                if (done_counting)
                    Wait_next = 1;
                else
                    Count_next = 1;
            state[9]: // Wait
                if (ack)
                    S_next = 1;
                else
                    Wait_next = 1;
        endcase
    end

    // Output logic
    always @(*) begin
        done = 0;
        counting = 0;
        shift_ena = 0;

        case (1'b1)
            state[8]: // Count
                counting = 1;
            state[9]: // Wait
                done = 1;
            state[4], state[5], state[6], state[7]: // B0, B1, B2, B3
                shift_ena = 1;
        endcase
    end

endmodule
