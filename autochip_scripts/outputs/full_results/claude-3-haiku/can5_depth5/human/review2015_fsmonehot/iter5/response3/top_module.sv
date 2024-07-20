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

        case (1'b1)
            state[0]: begin
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            state[1]: begin
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            state[2]: begin
                if (d)
                    S11_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            state[3]: begin
                if (d)
                    B3_next = 1'b1;
                else
                    S110_next = 1'b1;
            end
            state[8]: begin
                if (done_counting)
                    Wait_next = 1'b1;
                else
                    Count_next = 1'b1;
            end
            state[9]: begin
                if (ack)
                    S_next = 1'b1;
                else
                    Wait_next = 1'b1;
            end
            default: begin
                // Stay in the same state
            end
        endcase
    end

    // Output logic
    always @(*) begin
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        if (state[9]) begin
            done = 1'b1;
        end
        if (state[8]) begin
            counting = 1'b1;
        end
        if (state[4] || state[5] || state[6] || state[7]) begin
            shift_ena = 1'b1;
        end
    end

endmodule
