module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// Based on the provided simulation waveforms, the output q should have the following behavior:
// q = 0 when a = 0 and b = 0
// q = 1 when a = 0 and b = 1 and c = 1
// q = 1 when a = 1 and (c = 0 or d = 1)

assign q = (a == 0 && b == 1 && c == 1) || (a == 1 && (c == 0 || d == 1));

endmodule
