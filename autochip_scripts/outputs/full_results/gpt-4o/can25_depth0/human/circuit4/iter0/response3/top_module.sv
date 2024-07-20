module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (b | c);  // From the waveforms, q is 1 if b or c is 1, irrespective of a and d
endmodule
