module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Based on the given waveform table, we can deduce that:
    // q = b & (c | d) | a & d;

    assign q = (b & (c | d)) | (a & d);

endmodule
