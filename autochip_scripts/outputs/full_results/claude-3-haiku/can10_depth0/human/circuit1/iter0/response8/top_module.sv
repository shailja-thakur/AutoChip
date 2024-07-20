module top_module (
    input a, 
    input b, 
    output q
);

// The provided simulation waveforms indicate that the circuit performs the following logic:
// q = 0 when a = 0 and b = 0 or 1
// q = 1 when a = 1 and b = 1

assign q = a & b;

endmodule
