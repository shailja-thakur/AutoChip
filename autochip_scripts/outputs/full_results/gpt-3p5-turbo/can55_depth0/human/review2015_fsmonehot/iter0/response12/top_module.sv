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
always @*
begin
    case(state)
        10'b0000000001: // S
            begin
                if (d == 1)
                    S_next = 1'b0;
                else
                    S_next = 1'b1;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0000000010: // S1
            begin
                if (d == 1)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                S_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0000000100: // S11
            begin
                if (d == 1)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
                S_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0000010000: // S110
            begin
                if (d == 1)
                    B3_next = 1'b1;
                else
                    B3_next = 1'b0;
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0000100000: // B0
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0001000000: // B1
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0010000000: // B2
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b0100000000: // B3
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b1;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
        10'b1000000000: // Count
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b1;
                Wait_next = 1'b0;
            end
        10'b0000001000: // Wait
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b1;
            end
        default: // Default state
            begin
                S_next = 1'b0;
                S1_next = 1'b0;
                B3_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
            end
    endcase
end

// Output logic
always @*
begin
    done = state[9]; // done = MSB of current state

    case(state)
        10'b0000000001, // S
        10'b0000000010, // S1
        10'b0000000100, // S11
        10'b0000010000, // S110
        10'b0000100000, // B0
        10'b0001000000, // B1
        10'b0010000000, // B2
        10'b0100000000, // B3
        10'b1000000000: // Count
            begin
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        10'b0000001000: // Wait
            begin
                counting = 1'b1;
                shift_ena = 1'b0;
            end
        default: // Default state
            begin
                counting = 1'b0;
                shift_ena = 1'b1;
            end
    endcase
end

endmodule
