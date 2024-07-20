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
    // State encoding
    parameter S     = 10'b0000000001,
              S1    = 10'b0000000010,
              S11   = 10'b0000000100,
              S110  = 10'b0000001000,
              B0    = 10'b0000010000,
              B1    = 10'b0000100000,
              B2    = 10'b0001000000,
              B3    = 10'b0010000000,
              Count = 10'b0100000000,
              Wait  = 10'b1000000000;

    // Next-state logic
    always @(*) begin
        // Default values
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        B3_next = 0;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case (1'b1) // synthesis parallel_case
            state[0]: begin // S
                if (d)
                    S1_next = 1;
                else
                    S_next = 1;
            end
            state[1]: begin // S1
                if (d)
                    S11_next = 1;
                else
                    S_next = 1;
            end
            state[2]: begin // S11
                if (d)
                    S11_next = 1;
                else
                    S110_next = 1;
            end
            state[3]: begin // S110
                if (d)
                    B0_next = 1;
                else
                    S_next = 1;
            end
            state[4]: begin // B0
                B1_next = 1;
                shift_ena = 1;
            end
            state[5]: begin // B1
                B2_next = 1;
                shift_ena = 1;
            end
            state[6]: begin // B2
                B3_next = 1;
                shift_ena = 1;
            end
            state[7]: begin // B3
                Count_next = 1;
                shift_ena = 1;
            end
            state[8]: begin // Count
                if (done_counting)
                    Wait_next = 1;
                else
                    Count_next = 1;
                counting = 1;
            end
            state[9]: begin // Wait
                done = 1;
                if (ack)
                    S_next = 1;
                else
                    Wait_next = 1;
            end
        endcase
    end
endmodule
