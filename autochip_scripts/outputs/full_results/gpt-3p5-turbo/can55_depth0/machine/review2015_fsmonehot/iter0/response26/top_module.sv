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
    // Check if any of the states B3, B2, B1, and B0 is active
    shift_ena = (state[7] | state[6] | state[5] | state[4]);
    
    // Determine B3_next when state B2 is active
    B3_next = (state[6]);
    
    // Determine S_next
    S_next = (state[9] & ~d) | (state[8] & ~d) | (state[3] & ~d) | (state[0] & ack);
    
    // Determine S1_next
    S1_next = (state[9] & d);
    
    // Determine Count_next
    Count_next = (state[6] | (state[2] & ~done_counting));
    
    // Determine Wait_next
    Wait_next = (state[2] & done_counting) | (state[1] & ~ack);
    
    // Determine the done signal
    done = (state[1] & ~ack);
    
    // Determine the counting signal
    counting = (state[2] & ~done_counting);
 end

endmodule
