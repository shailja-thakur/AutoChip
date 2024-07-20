module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

    reg S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    
    always @* begin
        S = state[0];
        S1 = state[1];
        S11 = state[2];
        S110 = state[3];
        B0 = state[4];
        B1 = state[5];
        B2 = state[6];
        B3 = state[7];
        Count = state[8];
        Wait = state[9];
    end
    
    always @* begin
        B3_next = B2;
        
        S_next = S & !d | (!S & d);
        S1_next = S1 & !d | (!S1 & d);
        Count_next = Count & !done_counting | (!Count & done_counting);
        Wait_next = Wait & !done;
        
        done = Wait & ack;
        
        counting = (Count || (!B0 && !B1 && !B2 && !B3));
        
        shift_ena = (B0 || B1 || B2 || B3);
    end
    
endmodule
