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

    // State signals
    wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
    
    assign {S, S1, S11, S110, B0, B1, B2, B3, Count, Wait} = state;
    
    // done signal is 1 in the state Wait.
    assign done = Wait;
    
    // counting signal is 1 in the state Count.
    assign counting = Count;
    
    // shift_ena signal is 1 if any of the states B3, B2, B1 and B0 is active.
    assign shift_ena = B3 || B2 || B1 || B0;
    
    // output of the top module B3_next is 1 when the state B2 is active.
    always @* begin
        B3_next = B2;
    end
    
    // output of the top module S_next is 1 when the state S and d is 0, 
    // or the state S1 and d is 0, or the state S110 and d is 0, 
    // or the state Wait and ack is 1.
    always @* begin
        if ((S && !d) || (S1 && !d) || (S110 && !d) || (Wait && ack))
            S_next = 1;
        else
            S_next = 0;
    end
    
    // output of the top module S1_next is 1 when the state S and d is 1.
    always @* begin
        if (S && d)
            S1_next = 1;
        else
            S1_next = 0;
    end
    
    // output of the top module Count_next is 1 when the state B3 is active, 
    // or the state Count and done_counting is 0.
    always @* begin
        if (B3 || (Count && !done_counting))
            Count_next = 1;
        else
            Count_next = 0;
    end
    
    // output of the top module Wait_next is 1 when the state Count and done_counting is 1, 
    // or the state Wait and ack is 0.
    always @* begin
        if ((Count && done_counting) || (Wait && !ack))
            Wait_next = 1;
        else
            Wait_next = 0;
    end

endmodule
