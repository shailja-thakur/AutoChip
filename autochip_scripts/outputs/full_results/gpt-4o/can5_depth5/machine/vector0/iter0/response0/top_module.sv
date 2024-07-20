module top_module(
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);
    // Assign the vector output to be the same as the input vector
    assign outv = vec;

    // Assign each individual bit output to correspond to bits of the input vector
    assign o2 = vec[2]; // Most significant bit
    assign o1 = vec[1]; // Middle bit
    assign o0 = vec[0]; // Least significant bit
    
endmodule
