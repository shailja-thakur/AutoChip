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

    always @(*) begin
        // Next-state logic
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (state)
            10'b0000000001: begin // S
                S_next = ~d;
                S1_next = d;
            end
            10'b0000000010: begin // S1
                S_next = ~d;
                S1_next = d;
            end
            10'b0000000100: begin // S11
                S1_next = d;
                B3_next = d;
            end
            10'b0000001000: begin // S110
                S_next = ~d;
                B3_next = d;
            end
            10'b0010000000: begin // B3
                Count_next = 1'b1;
            end
            10'b1000000000: begin // Count
                Count_next = ~done_counting;
                Wait_next = done_counting;
            end
            10'b0100000000: begin // Wait
                Wait_next = ~ack;
                S_next = ack;
            end
            default: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        endcase

        // Output logic
        done = state[9];
        counting = state[8];
        shift_ena = state[4] | state[5] | state[6] | state[7];
    end

endmodule
