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

    // 	The top module is a state machine. There are 10 states in this state machine, which are S, S1, S11, S110, B0, B1, B2, B3, Count and Wait.
    parameter S = 10'b0000000001;
    parameter S1 = 10'b0000000010;
    parameter S11 = 10'b0000000100;
    parameter S110 = 10'b0000001000;
    parameter B0 = 10'b0000010000;
    parameter B1 = 10'b0000100000;
    parameter B2 = 10'b0001000000;
    parameter B3 = 10'b0010000000;
    parameter Count = 10'b0100000000;
    parameter Wait = 10'b1000000000;
    
    //  The done signal is 1 in the state Wait.
    assign done = (state == Wait) ? 1'b1 : 1'b0;
    
    //  The counting signal is 1 in the state Count.
    assign counting = (state == Count) ? 1'b1 : 1'b0;
    
    //  The shift_ena signal is 1 if any of the states B3, B2, B1 and B0 is active.
    assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0) ? 1'b1 : 1'b0;
    
    //  The output of the top module B3_next is 1 when the state B2 is active.
    assign B3_next = (state == B2) ? 1'b1 : 1'b0;
    
    //  The output of the top module S_next is 1 when the state S and d is 0, or the state S1 and d is 0, or the state S110 and d is 0, or the state Wait and ack is 1.
    assign S_next = ((state == S && d == 1'b0) || (state == S1 && d == 1'b0) || (state == S110 && d == 1'b0) || (state == Wait && ack == 1'b1)) ? 1'b1 : 1'b0;
    
    //  The output of the top module S1_next is 1 when the state S and d is 1.
    assign S1_next = (state == S && d == 1'b1) ? 1'b1 : 1'b0;
    
    //  The output of the top module Count_next is 1 when the state B3 is active, or the state Count and done_counting is 0.
    assign Count_next = ((state == B3) || (state == Count && done_counting == 1'b0)) ? 1'b1 : 1'b0;
    
    //  The output of the top module Wait_next is 1 when the state Count and done_counting is 1, or the state Wait and ack is 0.
    assign Wait_next = ((state == Count && done_counting == 1'b1) || (state == Wait && ack == 1'b0)) ? 1'b1 : 1'b0;

endmodule
