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

        case (1'b1)
            state[8]: // B3
                B3_next = !d;
            state[0]: // S
                S_next = !d;
            state[1]: // S1
                begin
                    S_next = !d;
                    S1_next = d;
                end
            state[2]: // S11
                S1_next = !d;
            state[7]: // Count
                begin
                    S_next = !d;
                    Count_next = done_counting;
                end
            state[9]: // Wait
                Wait_next = !ack | ack;
            default:
                begin
                    B3_next = 1'b0;
                    S_next = 1'b0;
                    S1_next = 1'b0;
                    Count_next = 1'b0;
                    Wait_next = 1'b0;
                end
        endcase
    end

    // Output logic
    always @(*) begin
        done = state[9];
        counting = state[7];
        shift_ena = (state[3] | state[4] | state[5] | state[6]);
    end

endmodule
