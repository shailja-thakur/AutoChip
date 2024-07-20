module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg S11_next,
    output reg S110_next,
    output reg B0_next,
    output reg B1_next,
    output reg B2_next,
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
        S11_next = 1'b0;
        S110_next = 1'b0;
        B0_next = 1'b0;
        B1_next = 1'b0;
        B2_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1) // Mux for current state
            state[0]: begin // S
                S_next = ~d;
                S1_next = d;
            end
            state[1]: begin // S1
                S_next = ~d;
                S1_next = ~d;
                S11_next = d;
            end
            state[2]: begin // S11
                S11_next = ~d;
                S110_next = d;
            end
            state[3]: begin // S110
                S_next = ~d;
                S110_next = ~d;
                B0_next = d;
            end
            state[4]: begin // B0
                B1_next = 1'b1;
            end
            state[5]: begin // B1
                B2_next = 1'b1;
            end
            state[6]: begin // B2
                B3_next = 1'b1;
            end
            state[7]: begin // B3
                Count_next = 1'b1;
            end
            state[8]: begin // Count
                Count_next = ~done_counting;
                Wait_next = done_counting;
            end
            state[9]: begin // Wait
                Wait_next = ~ack;
                S_next = ack;
            end
            default: begin
                // Stay in the current state
            end
        endcase
    end

    // Output logic
    always @(*) begin
        done = state[9];
        counting = state[8];
        shift_ena = state[4] | state[5] | state[6] | state[7];
    end

endmodule
