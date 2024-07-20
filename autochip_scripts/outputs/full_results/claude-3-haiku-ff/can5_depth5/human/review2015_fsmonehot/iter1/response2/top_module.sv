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
    output done,
    output counting,
    output shift_ena
 );

    // Next-state logic
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (state)
            10'b0000000001: begin // S
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            10'b0000000010: begin // S1
                if (d)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            10'b0000000100: begin // S11
                if (d)
                    S11_next = 1'b1;
                else
                    S110_next = 1'b1;
            end
            10'b0000001000: begin // S110
                if (d)
                    B0_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            10'b0000010000: begin // B0
                B1_next = 1'b1;
            end
            10'b0000100000: begin // B1
                B2_next = 1'b1;
            end
            10'b0001000000: begin // B2
                B3_next = 1'b1;
            end
            10'b0010000000: begin // B3
                Count_next = 1'b1;
            end
            10'b0100000000: begin // Count
                if (done_counting)
                    Wait_next = 1'b1;
                else
                    Count_next = 1'b1;
            end
            10'b1000000000: begin // Wait
                if (ack)
                    S_next = 1'b1;
                else
                    Wait_next = 1'b1;
            end
            default: begin
                S_next = 1'b1;
            end
        endcase
    end

    // Output logic
    assign done = state[9];
    assign counting = state[7];
    assign shift_ena = state[4] | state[5] | state[6] | state[7];

endmodule
