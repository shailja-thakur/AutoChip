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
        case(state)
            // Transition logic equations
            // B3_next
            10'b0111111111: B3_next = 1'b1;
            default: B3_next = 1'b0;

            // S_next
            10'b0000000001: S_next = 1'b1;
            default: S_next = 1'b0;

            // S1_next
            10'b0000000010: S1_next = 1'b1;
            default: S1_next = 1'b0;

            // Count_next
            10'b1000000000: Count_next = 1'b1;
            default: Count_next = 1'b0;

            // Wait_next
            10'b1000000000: Wait_next = 1'b1;
            default: Wait_next = 1'b0;
        endcase
    end

    always @(*) begin
        // Output logic equations
        // done
        done = (state == 10'b1000000001) ? 1'b1 : 1'b0;

        // counting
        counting = (state == 10'b1000000000) ? 1'b1 : 1'b0;

        // shift_ena
        shift_ena = (state >= 10'b0111100000 && state <= 10'b0111111111) ? 1'b1 : 1'b0;
    end

endmodule
