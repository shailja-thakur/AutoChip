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
    // State B3_next
    case (state)
        B2: B3_next = 1'b1;
        default: B3_next = 1'b0;
    endcase
    
    // State S_next
    case (state)
        S: 
            if (d == 1'b0) S_next = 1'b1;
            else S_next = 1'b0;
        S1: 
            if (d == 1'b0) S_next = 1'b1;
            else S_next = 1'b0;
        S110: 
            if (d == 1'b0) S_next = 1'b1;
            else S_next = 1'b0;
        Wait: 
            if (ack == 1'b1) S_next = 1'b1;
            else S_next = 1'b0;
        default: S_next = 1'b0;
    endcase
    
    // State S1_next
    case (state)
        S: 
            if (d == 1'b1) S1_next = 1'b1;
            else S1_next = 1'b0;
        default: S1_next = 1'b0;
    endcase
    
    // State Count_next
    case (state)
        B3: Count_next = 1'b1;
        Count: 
            if (done_counting == 1'b0) Count_next = 1'b1;
            else Count_next = 1'b0;
        default: Count_next = 1'b0;
    endcase
    
    // State Wait_next
    case (state)
        Count: 
            if (done_counting == 1'b1) Wait_next = 1'b1;
            else Wait_next = 1'b0;
        Wait: 
            if (ack == 1'b0) Wait_next = 1'b1;
            else Wait_next = 1'b0;
        default: Wait_next = 1'b0;
    endcase
 end

 // done signal
 assign done = state[9];
 
 // counting signal
 assign counting = state[7:4] == 4'b1011;
 
 // shift_ena signal
 assign shift_ena = (state & 4'b1111) != 0;
 
endmodule
