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
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1) // Mux based on current state
            state[0]: // State S
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            state[1]: // State S1
                if (d)
                    S11_next = 1'b1;
                else
                    S_next = 1'b1;
            state[2]: // State S11
                if (d)
                    S11_next = 1'b1;
                else
                    S110_next = 1'b1;
            state[3]: // State S110
                if (d)
                    B0_next = 1'b1;
                else
                    S_next = 1'b1;
            state[4]: // State B0
                B1_next = 1'b1;
            state[5]: // State B1
                B2_next = 1'b1;
            state[6]: // State B2
                B3_next = 1'b1;
            state[7]: // State Count
                if (done_counting)
                    Wait_next = 1'b1;
                else
                    Count_next = 1'b1;
            state[8]: // State B3
                if (!d)
                    S_next = 1'b1;
            state[9]: // State Wait
                if (ack)
                    S_next = 1'b1;
                else
                    Wait_next = 1'b1;
        endcase
    end

    // Output logic
    always @(*) begin
        done = state[9];
        counting = state[7];
        shift_ena = (state[3] | state[4] | state[5] | state[6]);
    end

endmodule
