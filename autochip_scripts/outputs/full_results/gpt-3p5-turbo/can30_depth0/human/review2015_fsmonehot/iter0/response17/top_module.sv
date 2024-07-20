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
always @(*)
begin
    case(state)
        // S state transition
        10'b0000000001:
            begin
                if(d == 1)
                    S_next = 1'b0;
                else
                    S_next = 1'b1;
            end
        // S1 state transition
        10'b0000000010:
            begin
                if(d == 1)
                    S1_next = 1'b1;
                else
                    S1_next = 1'b0;
            end
        // S11 state transition
        10'b0000000100:
            begin
                if(d == 1)
                    S1_next = 1'b1;
                else
                    S11_next = 1'b0;
            end
        // S110 state transition
        10'b0000001000:
            begin
                if(d == 1)
                    B0_next = 1'b0;
                else
                    S110_next = 1'b0;
            end
        // B0 state transition
        10'b0000010000:
            B1_next = 1'b1;
        // B1 state transition
        10'b0000100000:
            B2_next = 1'b1;
        // B2 state transition
        10'b0001000000:
            B3_next = 1'b1;
        // B3 state transition
        10'b0010000000:
            Count_next = 1'b1;
        // Count state transition
        10'b0100000000:
            begin
                if(done_counting == 1)
                    Wait_next = 1'b1;
                else
                    Count_next = 1'b1;
            end
        // Wait state transition
        10'b1000000000:
            begin
                if(ack == 1)
                    S_next = 1'b1;
                else
                    Wait_next = 1'b1;
            end
        default: // Any other state
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
always @(*)
begin
    case(state)
        // S outputs
        10'b0000000001:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        // S1 outputs
        10'b0000000010:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        // S11 outputs
        10'b0000000100:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        // S110 outputs
        10'b0000001000:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        // B0 outputs
        10'b0000010000:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
        // B1 outputs
        10'b0000100000:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
        // B2 outputs
        10'b0001000000:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
        // B3 outputs
        10'b0010000000:
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
        // Count outputs
        10'b0100000000:
            begin
                done = 1'b0;
                counting = 1'b1;
                shift_ena = 1'b0;
            end
        // Wait outputs
        10'b1000000000:
            begin
                done = 1'b1;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        default: // Any other state
            begin
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
    endcase
end

endmodule
