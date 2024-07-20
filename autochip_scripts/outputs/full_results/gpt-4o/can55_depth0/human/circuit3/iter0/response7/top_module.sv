module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    // From the given simulation waveforms, we can deduce the logic for q:
    // q is '1' when any of the following conditions are met:
    // - (b is 1 and d is 1)
    // - (b is 1 and c is 1)
    // - (a is 1 and d is 1)
    // - (a is 1 and c is 1)
    // Following this, q is given by the expression:
    // q = (b & d) | (b & c) | (a & d) | (a & c)
    assign q = (b & d) | (b & c) | (a & d) | (a & c);
endmodule
