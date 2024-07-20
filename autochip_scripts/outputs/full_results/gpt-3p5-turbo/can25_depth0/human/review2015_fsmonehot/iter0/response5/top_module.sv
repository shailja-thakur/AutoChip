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

// Combinational Logic
always @(*)
begin
    case(state)
        // State S
        10'b0000000001: begin
            B3_next = 1'b0;
            S_next = d ? 1'b1 : 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // State S1
        10'b0000000010: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = d ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // State S11
        10'b0000000100: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // State S110
        10'b0000001000: begin
            B3_next = 1'b1;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        // State B0
        10'b0000010000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // State B1
        10'b0000100000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // State B2
        10'b0001000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // State B3
        10'b0010000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        
        // State Count
        10'b0100000000: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = d ? 1'b1 : done_counting ? 1'b0 : 1'b1;
            Wait_next = done_counting ? 1'b1 : 1'b0;
            done = 1'b0;
            counting = 1'b1;
            shift_ena = 1'b0;
        end
        
        // State Wait
        10'b1000000000: begin
            B3_next = 1'b0;
            S_next = 1'b1;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ack ? 1'b0 : 1'b1;
            done = 1'b1;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        default: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
    endcase
end

endmodule
