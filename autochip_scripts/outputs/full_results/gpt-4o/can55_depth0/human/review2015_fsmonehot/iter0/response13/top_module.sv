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

    // State Encoding
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
    
    // Next state logic
    assign S_next = (state == S && d == 0) ? S : 
                    (state == S && d == 1) ? S1 :
                    (state == S1 && d == 1) ? S11 :
                    (state == S1 && d == 0) ? S :
                    (state == S11 && d == 0) ? S110 :
                    (state == S11 && d == 1) ? S11 :
                    (state == S110 && d == 0) ? S :
                    (state == S110 && d == 1) ? B0 : 
                    (state == B0) ? B1 :
                    (state == B1) ? B2 :
                    (state == B2) ? B3 :
                    (state == B3) ? Count :
                    (state == Count && done_counting == 0) ? Count :
                    (state == Count && done_counting == 1) ? Wait :
                    (state == Wait && ack == 0) ? Wait :
                    (state == Wait && ack == 1) ? S :
                    10'b0000000000;

    assign S1_next = (state == S && d == 1);
    assign Count_next = (state == B3);
    assign Wait_next = (state == Count && done_counting);

    // Output logic
    assign shift_ena = state == B0 || state == B1 || state == B2 || state == B3;
    assign counting = state == Count;
    assign done = state == Wait;

    // Next state conditions for specific states
    assign B3_next = state == B2;
    
endmodule
