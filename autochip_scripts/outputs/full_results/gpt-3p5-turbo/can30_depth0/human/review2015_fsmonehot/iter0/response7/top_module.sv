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
always @*
begin
    case(state)
        10'b0000000001:  // S
            begin
                if (d == 1)
                    S1_next = 1;
                else
                    S_next = 1;
            end
        
        10'b0000000010:  // S1
            begin
                if (d == 1)
                    S11_next = 1;
                else
                    S_next = 1;
            end
        
        10'b0000000100:  // S11
            begin
                if (d == 1)
                    S11_next = 1;
                else
                    S110_next = 1;
            end
        
        10'b0000001000:  // S110
            begin
                if (d == 1)
                    B0_next = 1;
                else
                    S_next = 1;
            end
        
        10'b0000010000:  // B0
            B1_next = 1;
        
        10'b0000100000:  // B1
            B2_next = 1;
        
        10'b0001000000:  // B2
            B3_next = 1;
        
        10'b0010000000:  // B3
            Count_next = 1;
        
        10'b0100000000:  // Count
            begin
                if (done_counting == 1)
                    Wait_next = 1;
                else
                    Count_next = 1;
            end
        
        10'b1000000000:  // Wait
            begin
                if (ack == 1)
                    S_next = 1;
                else
                    Wait_next = 1;
            end
    endcase
end

// Output logic
always @*
begin
    done = (state == 10'b1000000000);  // Output done when in Wait state
    counting = (state == 10'b0100000000);  // Output counting when in Count state
    shift_ena = (state >= 10'b0000010000) && (state <= 10'b0001000000);  // Output shift_ena when in B0, B1, B2, or B3 state
end

endmodule
