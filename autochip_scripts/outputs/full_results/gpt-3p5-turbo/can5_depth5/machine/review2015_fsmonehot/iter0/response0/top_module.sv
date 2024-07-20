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

// state machine states
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

always @* begin
    // done signal is 1 in the state Wait
    done = (state == Wait);
    
    // counting signal is 1 in the state Count
    counting = (state == Count);
    
    // shift_ena signal is 1 if any of the states B3, B2, B1, and B0 is active
    shift_ena = (state[B3] || state[B2] || state[B1] || state[B0]);
    
    // output of the top module B3_next is 1 when the state B2 is active
    B3_next = (state == B2);

    // output of the top module S_next is 1 when the state S and d is 0, or the state S1 and d is 0,
    // or the state S110 and d is 0, or the state Wait and ack is 1
    S_next = ((state == S && d == 0) || (state == S1 && d == 0) ||
              (state == S110 && d == 0) || (state == Wait && ack == 1));
    
    // output of the top module S1_next is 1 when the state S and d is 1
    S1_next = (state == S && d == 1);
    
    // output of the top module Count_next is 1 when the state B3 is active,
    // or the state Count and done_counting is 0
    Count_next = (state == B3 || (state == Count && done_counting == 0));
    
    // output of the top module Wait_next is 1 when the state Count and done_counting is 1,
    // or the state Wait and ack is 0
    Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0);
    
end

endmodule
