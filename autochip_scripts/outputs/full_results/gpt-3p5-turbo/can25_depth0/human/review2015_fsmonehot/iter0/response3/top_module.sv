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

// State transition and output logic equations
always @*
begin
    // Default next-state logic values
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    // State transition and output logic
    case(state)
        10'b0000000001: begin // S
            if (d == 1)
                S1_next = 1;
            else
                S_next = 1;
        end

        10'b0000000010: begin // S1
            if (d == 1)
                S11_next = 1;
            else
                S_next = 1;
        end

        10'b0000000100: begin // S11
            if (d == 1)
                S11_next = 1;
            else
                S110_next = 1;
        end

        10'b0000001000: begin // S110
            if (d == 1)
                B0_next = 1;
            else
                S_next = 1;
        end

        10'b0000010000: begin // B0
            B1_next = 1;
            shift_ena = 1;
        end

        10'b0000100000: begin // B1
            B2_next = 1;
            shift_ena = 1;
        end

        10'b0001000000: begin // B2
            B3_next = 1;
            shift_ena = 1;
        end

        10'b0010000000: begin // B3
            Count_next = 1;
            shift_ena = 1;
        end

        10'b0100000000: begin // Count
            counting = 1;
            if (!done_counting)
                Count_next = 1;
            else
                Wait_next = 1;
        end

        10'b1000000000: begin // Wait
            done = 1;
            if (ack == 1)
                S_next = 1;
            else
                Wait_next = 1;
        end
    endcase
end

endmodule
