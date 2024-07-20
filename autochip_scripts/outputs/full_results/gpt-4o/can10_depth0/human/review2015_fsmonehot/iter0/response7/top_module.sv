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

    // State encoding
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

    // Next-state logic
    assign S_next = (state == S  && d == 1 ) ? S1  : 
                    (state == S1 && d == 0 ) ? S   :
                    (state == S11 && d == 0 ) ? S110 :
                    (state == S110 && d == 0 ) ? S : 
                    (state == Wait && ack == 1) ? S: S;

    assign S1_next = (state == S  && d == 1 ) ? S1 : 
                     (state == S1 && d == 1 ) ? S11 : 
                     (state == Count && done_counting == 1) ? Wait : S1;

    assign S11_next = (state == S1 && d == 1) ? S11 :  
                      (state == S11 && d == 1) ? S11 : 
                      (state == B3) ? Count : S11;

    assign B3_next = (state == B2) ? B3 : B3;

    assign Count_next = (state == B3) ? Count : 
                        (state == Count && (done_counting == 0)) ? Count : 
                        (state == B3 || state == Count) ? Wait : Count;

    assign Wait_next = (state == Count && done_counting == 1) ? Wait : 
                       (state == Wait && ack == 1) ? S : Wait;

    // Output logic
    assign done = (state == Wait && ack == 0) ? 1 : 0;

    assign counting = (state == Count && done_counting == 0) ? 1 : 0;

    assign shift_ena = (state == B0 || state == B1 || state == B2 || state == B3) ? 1 : 0;

endmodule
