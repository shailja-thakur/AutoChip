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
    always @(state, d, done_counting) begin
        case(state)
            10'b0000000001: begin  // S
                if (d == 1'b0)
                    S_next = 1'b1;
                else if (d == 1'b1)
                    S1_next = 1'b1;
            end
            
            10'b0000000010: begin  // S1
                if (d == 1'b0)
                    S_next = 1'b1;
                else if (d == 1'b1)
                    S11_next = 1'b1;
            end
            
            10'b0000000100: begin  // S11
                if (d == 1'b0)
                    S110_next = 1'b1;
                else if (d == 1'b1)
                    S11_next = 1'b1;
            end
            
            10'b0000001000: begin  // S110
                if (d == 1'b0)
                    S_next = 1'b1;
                else if (d == 1'b1)
                    B0_next = 1'b1;
            end
            
            10'b0000000000: begin  // B0
                B1_next = 1'b1;
            end
            
            10'b0000000000: begin  // B1
                B2_next = 1'b1;
            end
            
            10'b0000000000: begin  // B2
                B3_next = 1'b1;
            end
            
            10'b0000000000: begin  // B3
                Count_next = 1'b1;
            end
            
            10'b0000000000: begin  // Count
                if (!done_counting)
                    Count_next = 1'b1;
                else
                    Wait_next = 1'b1;
            end
            
            10'b0000000000: begin  // Wait
                if (ack == 1'b0)
                    Wait_next = 1'b1;
                else if (ack == 1'b1)
                    S_next = 1'b1;
            end
        endcase
    end

    // Output logic
    always @(state) begin
        case(state)
            10'b0000000001: begin  // S
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            10'b0000000010: begin  // S1
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            10'b0000000100: begin  // S11
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            10'b0000001000: begin  // S110
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
            
            10'b0000000000: begin  // B0
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            10'b0000000000: begin  // B1
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            10'b0000000000: begin  // B2
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            10'b0000000000: begin  // B3
                done = 1'b0;
                counting = 1'b0;
                shift_ena = 1'b1;
            end
            
            10'b0000000000: begin  // Count
                done = 1'b0;
                counting = 1'b1;
                shift_ena = 1'b0;
            end
            
            10'b0000000000: begin  // Wait
                done = 1'b1;
                counting = 1'b0;
                shift_ena = 1'b0;
            end
        endcase
    end

endmodule
