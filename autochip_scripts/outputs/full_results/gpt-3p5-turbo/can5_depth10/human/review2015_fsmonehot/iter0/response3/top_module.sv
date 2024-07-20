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

    always @(*)
    begin
        case(state)
            10'b0000000100: begin    // S
                S_next = d ? 10'b0000000010 : state;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b0000000010: begin    // S1
                S_next = d ? 10'b0000000000 : state;
                S1_next = d ? 10'b0000000100 : state;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b0000000001: begin    // S11
                S_next = 10'b0000000000;
                S1_next = d ? 10'b0000000000 : state;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b0000000000: begin    // S110
                S_next = d ? 10'b0000000000 : state;
                S1_next = 10'b0000000000;
                Count_next = d ? 10'b1000000000 : state;
                Wait_next = 10'b0000000000;
            end
            
            10'b1111111110: begin    // B0
                S_next = 10'b0000000000;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b1111111100: begin    // B1
                S_next = 10'b0000000000;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b1111111000: begin    // B2
                S_next = 10'b0000000000;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b1111110000: begin    // B3
                S_next = 10'b0000000000;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
            
            10'b1000000000: begin    // Count
                S_next = 10'b0000000000;
                S1_next = 10'b0000000000;
                Count_next = done_counting ? 10'b0000000100 : state;
                Wait_next = done_counting ? 10'b0000000000 : state;
            end
            
            10'b0100000000: begin    // Wait
                S_next = d ? 10'b0000000010 : state;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = ack ? 10'b0000000001 : state;
            end
            
            default: begin
                S_next = 10'b0000000000;
                S1_next = 10'b0000000000;
                Count_next = 10'b0000000000;
                Wait_next = 10'b0000000000;
            end
        endcase
        
        done = state[9];
        counting = state[8];
        shift_ena = state[7];
        B3_next = state[6];
    end
endmodule
