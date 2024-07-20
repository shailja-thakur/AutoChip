module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Assign q based on the conditions observed from the simulation waveform
    assign q = (c & ~d) | (b & ~d);
endmodule
