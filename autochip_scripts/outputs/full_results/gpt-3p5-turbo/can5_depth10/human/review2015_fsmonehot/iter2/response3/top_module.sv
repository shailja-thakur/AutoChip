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
        // S
        10'b0000000001: begin
            S_next = (~d);
            S1_next = d;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // S1
        10'b0000000010: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // S11
        10'b0000000100: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // S110
        10'b0000001000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // B0
        10'b0000010000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // B1
        10'b0000100000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // B2
        10'b0001000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // B3
        10'b0010000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b1;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // Count
        10'b0100000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b1;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b1;
            shift_ena = 1'b1;
        end
        
        // Wait
        10'b1000000000: begin
            S_next = 1'b1;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b1;
            done = 1'b1;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
    endcase
end

endmodule
