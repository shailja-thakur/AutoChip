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

always @(*) begin
    case(state)
        S: begin
            if(d == 0)
                S_next = 1;
            else
                S_next = 0;
            B3_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S1: begin
            if(d == 0)
                S1_next = 1;
            else
                S1_next = 0;
            B3_next = 0;
            S_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        S11, S110: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        B0, B1, B2, B3: begin
            S_next = 0;
            S1_next = 0;
            if(state == B2)
                B3_next = 1;
            else
                B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        
        Count: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            if(state == B3 || done_counting == 0)
                Count_next = 1;
            else
                Count_next = 0;
            Wait_next = 0;
        end
        
        Wait: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            if(state == Count && done_counting == 1 || ack == 0)
                Wait_next = 1;
            else
                Wait_next = 0;
        end
        
        default: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
    endcase
    
    if(state == Wait)
        done = 1;
    else
        done = 0;
        
    if(state == Count)
        counting = 1;
    else
        counting = 0;
        
    if(state == B3 || state == B2 || state == B1 || state == B0)
        shift_ena = 1;
    else
        shift_ena = 0;
end

endmodule
