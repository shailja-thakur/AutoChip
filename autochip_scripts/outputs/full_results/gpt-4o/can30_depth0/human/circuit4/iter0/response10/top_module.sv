module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // From the waveform analysis, 'q' is '1' when either (b is '1') or (c is '1')
    assign q = b | c;
endmodule
