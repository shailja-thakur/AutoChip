module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

reg B3_next, S_next, S1_next, Count_next, Wait_next;
reg done, counting, shift_ena;

always @(*)
begin
    case(state)
        10'b0000000001: begin
            B3_next = 1'b1;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
        10'b0000000010: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        
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
        
        // Add remaining cases for other states
        
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
    end
end
endmodule
