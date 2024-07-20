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

    // State Bits
    parameter S      = 10'b0000_0000_01;
    parameter S1     = 10'b0000_0000_10;
    parameter S11    = 10'b0000_0001_00;
    parameter S110   = 10'b0000_0010_00;
    parameter B0     = 10'b0000_0100_00;
    parameter B1     = 10'b0000_1000_00;
    parameter B2     = 10'b0001_0000_00;
    parameter B3     = 10'b0010_0000_00;
    parameter Count  = 10'b0100_0000_00;
    parameter Wait   = 10'b1000_0000_00;

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

        case (state)
            S: begin
                if (!d) S_next = 1;
                else    S1_next = 1;
            end
            S1: begin
                if (!d) S_next = 1;
                // Default S1_next is 0
            end
            S11: begin
                if (!d) S_next = 1;
                // Default S1_next is 0
            end
            S110: begin
                if (!d) S_next = 1;
                // Default S1_next is 0
            end
            B0, B1, B2, B3: begin
                shift_ena = 1;
                if (state == B3) Count_next = 1;
                if (state == B2) B3_next = 1;
                // Default transition for B0, B1, B2 and B3
            end
            Count: begin
                counting = 1;
                if (!done_counting) Count_next = 1;
                else Wait_next = 1;
            end
            Wait: begin
                done = 1;
                if (!ack) Wait_next = 1;
                else S_next = 1;
            end
            default: ;
        endcase
    end

endmodule
