module top_module (
    input a,
    input b,
    output q
);

// The given simulation waveforms show that the output q is 0 when a and b are both 0, or when either a or b is 0.
// The output q is 1 when both a and b are 1.

assign q = a & b;

endmodule
