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

// State transition logic
always @(*) begin
    // Default values
    S_next = 1'b0;
    S1_next = 1'b0;
    Count_next = 1'b0;
    Wait_next = 1'b0;
    B3_next = 1'b0;

    case (state)
        10'b0000000001: // S
            if (d == 1'b0)
                S_next = 1'b1;
            else
                S1_next = 1'b1;
        10'b0000000010: // S1
            if (d == 1'b0)
                S_next = 1'b1;
            else
                S1_next = 1'b1;
        10'b0000000100: // S11
            if (d == 1'b0)
                S110_next = 1'b1;
            else
                S11_next = 1'b1;
        10'b0000001000: // S110
            if (d == 1'b0)
                S_next = 1'b1;
            else
                B0_next = 1'b1;
        10'b0000010000: // B0
            B1_next = 1'b1;
        10'b0000100000: // B1
            B2_next = 1'b1;
        10'b0001000000: // B2
            B3_next = 1'b1;
        10'b0010000000: // B3
            Count_next = 1'b1;
        10'b0100000000: // Count
            if (done_counting)
                Wait_next = 1'b1;
            else
                Count_next = 1'b1;
        10'b1000000000: // Wait
            if (ack)
                S_next = 1'b1;
            else
                Wait_next = 1'b1;
        default:
            S_next = 1'b1;
    endcase
end

// Output logic
always @(*) begin
    done = 1'b0;
    counting = 1'b0;
    shift_ena = 1'b0;

    case (state)
        10'b0010000000: // B3
            shift_ena = 1'b1;
        10'b0100000000: // Count
            counting = 1'b1;
        10'b1000000000: // Wait
            done = 1'b1;
    endcase
end

endmodule
