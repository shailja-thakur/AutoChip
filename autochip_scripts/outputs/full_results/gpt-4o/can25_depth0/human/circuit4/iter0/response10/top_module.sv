module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// Implement the logic based on the given waveform
assign q = (c & ~a) | (b & (~a | c));

endmodule
