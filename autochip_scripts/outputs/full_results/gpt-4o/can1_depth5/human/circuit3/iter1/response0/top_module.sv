module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Based on the given waveform table, we can deduce that:
    // q is high when either (a & d) or (b & (c | d)) are true.
    // After examining the waveforms again, precise conditions can be deduced:
    // q = (a & d) | (b & (c | d))

    assign q = (a & d) | (b & (c | d));

endmodule
