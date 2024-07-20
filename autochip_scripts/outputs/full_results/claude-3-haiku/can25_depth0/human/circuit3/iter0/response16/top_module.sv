module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// The given simulation waveforms indicate that the output q should be 1 when the following conditions are true:
// 1. d is 1 and c is 0
// 2. b is 1 and c is 0
// 3. b is 1 and c is 1
// 4. a is 1 and (c is 0 or d is 1)

assign q = (d & ~c) | (b & ~c) | (b & c) | (a & (~c | d));

endmodule
