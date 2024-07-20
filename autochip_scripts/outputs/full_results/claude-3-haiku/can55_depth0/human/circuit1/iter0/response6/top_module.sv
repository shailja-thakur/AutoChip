module top_module (
    input a, 
    input b, 
    output q
);

// Implement the logic based on the given simulation waveforms
assign q = (a & b) | (~a & ~b);

endmodule
