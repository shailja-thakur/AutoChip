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

    // State encodings
    parameter S      = 10'b0000000001;
    parameter S1     = 10'b0000000010;
    parameter S11    = 10'b0000000100;
    parameter S110   = 10'b0000001000;
    parameter B0     = 10'b0000010000;
    parameter B1     = 10'b0000100000;
    parameter B2     = 10'b0001000000;
    parameter B3     = 10'b0010000000;
    parameter Count  = 10'b0100000000;
    parameter Wait   = 10'b1000000000;

    // Next state logic
    assign S_next      = (state == S && d == 0) ? 1 :
                         (state == S1 && d == 0) ? 1 : 
                         (state == S110 && d == 0) ? 1 :
                         (state == Wait && ack == 1) ? 1 : 0;

    assign S1_next     = (state == S && d == 1) ? 1 :
                         (state == S1 && d == 1) ? 1 : 0;

    assign B3_next     = (state == B2) ? 1 : 0;

    assign Count_next  = (state == B3) ? 1 :
                         (state == Count && !done_counting) ? 1 : 0;

    assign Wait_next   = (state == Count && done_counting) ? 1 :
                         (state == Wait && ack == 0) ? 1 : 0;

    // Output logic
    assign shift_ena  = (state == B0 || state == B1 || state == B2 || state == B3) ? 1 : 0;
    assign counting   = (state == Count) ? 1 : 0;
    assign done       = (state == Wait) ? 1 : 0;

endmodule
