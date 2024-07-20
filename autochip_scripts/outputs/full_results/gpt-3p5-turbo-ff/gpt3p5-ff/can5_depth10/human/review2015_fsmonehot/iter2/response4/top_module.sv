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

    wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    
    assign S = state[0];
    assign S1 = state[1];
    assign S11 = state[2];
    assign S110 = state[3];
    assign B0 = state[4];
    assign B1 = state[5];
    assign B2 = state[6];
    assign B3 = state[7];
    assign Count = state[8];
    assign Wait = state[9];
    
    always @(S or S1 or S11 or B0 or B1 or B2 or B3 or Count or Wait or d or done_counting or ack) begin
        S_next = ({1'b0, d} & S) | ({1'b1, !d} & S1);
        S1_next = ({1'b0, d} & S1) | ({1'b1, !d} & S11);
        Count_next = ({1'b0, !done_counting} & Count) | ({1'b1, done_counting} & S11);
        Wait_next = (Wait & !done) | (Count & done_counting);
      
        done = (Wait & !ack);
      
        counting = (Count || (!B0 && !B1 && !B2 && !B3));
      
        shift_ena = (B0 || B1 || B2 || B3);
      
        B3_next = B2;
    end

endmodule
