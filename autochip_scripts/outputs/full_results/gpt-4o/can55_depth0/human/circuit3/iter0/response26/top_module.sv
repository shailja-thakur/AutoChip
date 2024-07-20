module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Implementing q based on the provided simulation waveform
    assign q = (b & d) | (a & (c | d));

endmodule
